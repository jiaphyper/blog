#!/usr/bin/env bash
# 交互式创建新文章草稿：选栏目 -> 是否双语 -> 标题 -> 是否需要图片
# 全部确认无误后才会真正创建文件；中途任何一步失败/取消都不会留下半成品。
set -u
set -o pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

SECTIONS=(growth papers pbl research)
SECTION_LABELS=("成长 growth" "论文笔记 papers" "PBL 案例 pbl" "小项目研究 research")

CREATED_FILES=()
CREATED_DIRS=()

rollback() {
  for f in "${CREATED_FILES[@]:-}"; do
    [ -n "$f" ] && [ -f "$f" ] && rm -f "$f"
  done
  for d in "${CREATED_DIRS[@]:-}"; do
    [ -n "$d" ] && [ -d "$d" ] && rmdir "$d" 2>/dev/null
  done
}

on_interrupt() {
  echo
  echo "已中断，正在清理…" >&2
  rollback
  echo "未保留任何新文件。" >&2
  exit 130
}
trap on_interrupt INT TERM

# 创建前的输入/校验错误：这一步之前什么都还没建，直接退出即可
abort() {
  echo "错误：$1" >&2
  echo "未创建任何文件。" >&2
  exit 1
}

# 创建过程中途出错：回滚这次已经建好的文件/文件夹
fail() {
  echo "错误：$1" >&2
  rollback
  echo "已回滚，未保留任何新文件。" >&2
  exit 1
}

sed_escape() {
  printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'
}

echo "=== 新建文章草稿 ==="
echo

# 1. 选择栏目
echo "请选择要写的栏目："
for i in "${!SECTIONS[@]}"; do
  printf "  %d) %s\n" "$((i + 1))" "${SECTION_LABELS[$i]}"
done
SECTION=""
while true; do
  read -r -p "输入编号 [1-${#SECTIONS[@]}]（Ctrl+C 随时退出）: " choice
  if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#SECTIONS[@]} )); then
    SECTION="${SECTIONS[$((choice - 1))]}"
    break
  fi
  echo "输入无效，请输入 1-${#SECTIONS[@]} 之间的数字。"
done
echo "→ 栏目：$SECTION"
echo

# 2. 是否需要英文版
BILINGUAL="no"
while true; do
  read -r -p "是否需要同时创建英文版？[y/N]: " ans
  case "$ans" in
    y | Y) BILINGUAL="yes"; break ;;
    n | N | "") BILINGUAL="no"; break ;;
    *) echo "请输入 y 或 n。" ;;
  esac
done
echo "→ 英文版：$BILINGUAL"
echo

# 3. 标题
TITLE=""
while true; do
  read -r -p "请输入文章标题: " TITLE
  [ -n "$TITLE" ] && break
  echo "标题不能为空。"
done

# 生成文件名 slug：转小写、空白换成 -、去掉文件名不安全字符、合并多余的 -
SLUG="$(printf '%s' "$TITLE" | tr '[:upper:]' '[:lower:]' | tr -s '[:space:]' '-')"
SLUG="$(printf '%s' "$SLUG" | tr -d '/\\:*?"<>|')"
SLUG="$(printf '%s' "$SLUG" | sed -E 's/-+/-/g; s/^-+//; s/-+$//')"
[ -z "$SLUG" ] && abort "标题无法转换出合法的文件名（结果为空），换个标题再试。"

echo "→ 标题：$TITLE"
echo "→ 文件名：$SLUG"
echo

# 4. 是否需要图片文件夹
NEED_IMAGES="no"
while true; do
  read -r -p "是否需要图片文件夹？[y/N]: " ans
  case "$ans" in
    y | Y) NEED_IMAGES="yes"; break ;;
    n | N | "") NEED_IMAGES="no"; break ;;
    *) echo "请输入 y 或 n。" ;;
  esac
done
echo "→ 图片文件夹：$NEED_IMAGES"
echo

DRAFT_DIR="content/${SECTION}/drafts"
ZH_FILE="${DRAFT_DIR}/${SLUG}.md"
EN_FILE="${DRAFT_DIR}/${SLUG}.en.md"
IMG_DIR="${DRAFT_DIR}/${SLUG}"

# 提前检查冲突：只要有一项已存在就整体中止，不动任何文件
[ -e "$ZH_FILE" ] && abort "文件已存在：$ZH_FILE"
[ "$BILINGUAL" = "yes" ] && [ -e "$EN_FILE" ] && abort "文件已存在：$EN_FILE"
[ "$NEED_IMAGES" = "yes" ] && [ -e "$IMG_DIR" ] && abort "图片文件夹已存在：$IMG_DIR"

# 5. 最终确认
echo "=== 即将创建 ==="
echo "栏目:      $SECTION"
echo "标题:      $TITLE"
echo "中文草稿:  $ZH_FILE"
[ "$BILINGUAL" = "yes" ] && echo "英文草稿:  $EN_FILE"
[ "$NEED_IMAGES" = "yes" ] && echo "图片文件夹: $IMG_DIR/"
echo
read -r -p "确认创建以上内容？[y/N]: " confirm
case "$confirm" in
  y | Y) ;;
  *)
    echo "已取消，未创建任何文件。"
    trap - INT TERM
    exit 0
    ;;
esac
echo

mkdir -p "$DRAFT_DIR"

# 6. 创建中文草稿
if ! hugo new content "$ZH_FILE" >/dev/null; then
  fail "hugo new 创建中文草稿失败：$ZH_FILE"
fi
CREATED_FILES+=("$ZH_FILE")

YAML_TITLE="${TITLE//\"/\\\"}"
SED_TITLE="$(sed_escape "$YAML_TITLE")"
if ! sed -i '' "s/^title:.*/title: \"${SED_TITLE}\"/" "$ZH_FILE"; then
  fail "写入标题失败：$ZH_FILE"
fi
echo "已创建：$ZH_FILE"

# 7. 创建英文草稿
if [ "$BILINGUAL" = "yes" ]; then
  if ! hugo new content "$EN_FILE" >/dev/null; then
    fail "hugo new 创建英文草稿失败：$EN_FILE"
  fi
  CREATED_FILES+=("$EN_FILE")
  if ! sed -i '' "s/^title:.*/title: \"${SED_TITLE}\"/" "$EN_FILE"; then
    fail "写入标题失败：$EN_FILE"
  fi
  echo "已创建：$EN_FILE"
fi

# 8. 创建图片文件夹，并在正文里插入图片引用示例（英文版需要绝对路径，见下面的说明）
if [ "$NEED_IMAGES" = "yes" ]; then
  if ! mkdir -p "$IMG_DIR"; then
    fail "创建图片文件夹失败：$IMG_DIR"
  fi
  CREATED_DIRS+=("$IMG_DIR")
  echo "已创建图片文件夹：$IMG_DIR/"

  {
    echo ""
    echo "<!-- 图片示例：把图片放进 ${IMG_DIR}/，中文正文里直接用文件名引用 -->"
    echo "<!--"
    echo "<center>"
    echo "  <img src=\"fig1.avif\" alt=\"描述\" style=\"width:60%; max-width:800px;\">"
    echo "</center>"
    echo "-->"
  } >> "$ZH_FILE"

  if [ "$BILINGUAL" = "yes" ]; then
    {
      echo ""
      echo "<!-- Image example: English page must use the ABSOLUTE path below,"
      echo "     because the shared images are only published under the Chinese path. -->"
      echo "<!--"
      echo "<center>"
      echo "  <img src=\"/${SECTION}/drafts/${SLUG}/fig1.avif\" alt=\"description\" style=\"width:60%; max-width:800px;\">"
      echo "</center>"
      echo "-->"
    } >> "$EN_FILE"
    echo "已在英文草稿中插入图片 src 示例（记得把 fig1.avif 换成实际文件名并取消注释）。"
  fi
fi

echo
echo "=== 完成 ==="
echo "本地预览（含草稿）：hugo server -D"
if [ "$NEED_IMAGES" = "yes" ] && [ "$BILINGUAL" = "yes" ]; then
  echo "注意：正式发布、把文件移出 drafts/ 后，英文 md 里图片 src 的 /${SECTION}/drafts/${SLUG}/ 要改成 /${SECTION}/${SLUG}/（去掉 drafts 段）。"
fi
echo "发布时：把 ${SLUG}.md$( [ "$BILINGUAL" = "yes" ] && printf '、%s.en.md' "$SLUG" )$( [ "$NEED_IMAGES" = "yes" ] && printf '、%s/ 图片文件夹' "$SLUG" ) 一起移出 drafts/ 到 content/${SECTION}/ 下，再把 draft: true 删掉。"

trap - INT TERM
exit 0

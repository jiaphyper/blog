# jiaphyper.com — Site README

## 目录

- [本地运行](#本地运行)
- [目录结构](#目录结构)
- [创建成长文章](#创建成长文章)
- [创建论文笔记](#创建论文笔记)
- [本地图片](#本地图片)
- [数学公式](#数学公式)
- [插入 YouTube 视频](#插入-youtube-视频)
- [首页文案与栏目开关](#首页文案与栏目开关)
- [Footer 社交链接配置](#footer-社交链接配置)
- [中英文内容](#中英文内容)
- [部署上线](#部署上线)
- [常见操作速查](#常见操作速查)

---

## 本地运行

```bash
cd jiaphyper
hugo server
```

浏览器打开 `http://localhost:1313` 预览。修改任何文件后页面自动刷新。

---

## 目录结构

```
jiaphyper/
├── content/
│   ├── _index.md          ← 首页
│   ├── growth/            ← 成长文章
│   └── papers/            ← 论文笔记
├── layouts/               ← 页面模板
├── static/
│   ├── css/main.css       ← 样式
│   ├── js/main.js         ← 交互逻辑
│   └── images/            ← 本地图片（含微信二维码）
└── hugo.toml              ← 站点配置
```

---

## 创建成长文章

### 新建

```bash
hugo new growth/your-article-slug.md
```

### Front matter 字段

```yaml
---
title: "为什么我开始记录自己的阅读"
date: 2026-05-10
tags: ["阅读", "习惯"]
summary: "不是为了记住，而是为了真正思考过。"
draft: false              # true = 草稿，不发布
---

正文用 Markdown 写在这里。
```

### tags 建议

随意填写，显示在文章列表的标签上。建议保持一致，比如：`阅读`、`习惯`、`时间`、`思考`、`教学`。

---

## 创建论文笔记

### 新建

```bash
hugo new papers/paper-slug.md
```

### Front matter 字段

```yaml
---
title: "为什么教科书里的简谐运动推导是错的"
date: 2026-05-08
journal: "The Physics Teacher"   # 期刊名称
authors: "R. A. Morse"           # 作者
year: 2019
doi: "10.1119/1.5092484"         # DOI 号，不含 https://doi.org/
summary: "一句话介绍这篇论文。"
tags: ["力学", "教学法"]
draft: false
---

## 论文在说什么

## 关键公式或结论

## 我的想法
```

`doi` 填写后，页面顶部会自动显示论文信息条，并生成跳转链接。

---

## 本地图片

图片文件放到 `static/images/` 目录下，在 Markdown 里用绝对路径引用：

```markdown
![图片描述](/images/your-image.jpg)
```

### 微信二维码

微信二维码图片放到：

```
static/images/wechat.png
```

鼠标悬停到 footer 的微信图标时自动显示。替换这个文件即可更新二维码，不需要改任何代码。

---

## 数学公式

站点已配置 KaTeX，直接在 Markdown 里写：

**行内公式**（前后用单个 `$`）：

```markdown
质量-能量等价 $E = mc^2$ 是相对论的核心结论。
```

**独立公式**（前后用 `$$`）：

```markdown
$$
a = \frac{v^2}{r}
$$
```

---

## 插入 YouTube 视频

文章中可以使用 YouTube shortcode，支持位置参数或命名参数：

```markdown
{{</* youtube "VIDEO_ID" */>}}
```

```markdown
{{</* youtube id="VIDEO_ID" title="视频标题" */>}}
```

只填写 YouTube 链接中 `v=` 后面的视频 ID。视频会使用 16:9 响应式布局。

---

## 首页文案与栏目开关

首页顶部的标题、描述和右侧 Field Notes 卡片，都可以在 `hugo.toml` 的
`[params.home]` 中修改：

```toml
[params.home]
  eyebrow = "物理 · 成长 · 阅读"
  title = "JiaPhyper"
  description = "读论文，写笔记，记录成长。"
  subdescription = "一个物理老师的个人空间。"
  asideLabel = "JIA'S FIELD NOTES"
  asideQuote = "把复杂的世界，讲得更清楚一点。"
  asideNote = "Teaching · Reading · Writing"
  asideTopics = ["物理", "教学", "写作"]
```

所有栏目都在 `[params.sections.栏目名]` 中配置。模板会按 `weight` 排序，
并自动生成导航、首页按钮、首页内容列表和右侧数量统计：

```toml
[params.sections.growth]
  id = "growth"
  enabled = true
  weight = 10
  navLabel = "成长"
  buttonLabel = "成长文章"
  homeTitle = "近期文章"
  homeLimit = 4
  secondaryField = "summary"
  listTitle = "成长"
  listNoun = "文章"
  tagGroup = "growth"
```

将某个 `enabled` 改成 `false`，会同时隐藏首页按钮、首页对应内容板块、
桌面导航和移动端导航中的链接。内容文件不会删除，重新改回 `true` 即可恢复。

### 新增普通栏目

例如新增 PBL 案例，只需：

1. 在 `hugo.toml` 中新增配置：

```toml
[params.sections.pbl]
  id = "pbl"
  enabled = true
  weight = 30
  navLabel = "PBL 案例"
  buttonLabel = "PBL 案例"
  homeTitle = "近期 PBL 案例"
  homeLimit = 4
  secondaryField = "summary"
  listTitle = "PBL 案例"
  listNoun = "案例"
  tagGroup = "pbl"
```

2. 新建 `content/pbl/_index.md`：

```yaml
---
title: "PBL 案例"
---
```

3. 在 `content/pbl/` 中新增 Markdown 文章。

配置表名称、`id` 和内容目录名称必须一致。普通栏目默认使用文章列表样式；
`secondaryField` 指定首页标题下方显示的 front matter 字段，通常使用 `summary`。
`tagGroup` 指定该栏目的标签在标签页中归入哪个分组。

右上角的“标签”入口使用独立开关：

```toml
[params.tags]
  enabled = true
  navLabel = "标签"
```

文章中的标签可以点击。`/tags/` 显示所有标签，进入某个标签后会显示
包含该标签的全部已启用栏目内容。

标签分组在 `[params.tagGroups.分组名]` 中配置：

```toml
[params.tagGroups.growth]
  id = "growth"
  label = "个人成长"
  weight = 10

[params.tagGroups.papers]
  id = "papers"
  label = "论文笔记"
  weight = 20
```

例如将 PBL 的 `tagGroup` 从 `"pbl"` 改成 `"growth"`，PBL 标签就会归入
“个人成长”分组。栏目关闭时，它的标签分组也不会显示。

---

## Footer 社交链接配置

联系方式统一在 `hugo.toml` 的 `[[params.footer.contacts]]` 中配置，不需要修改模板：

```toml
[[params.footer.contacts]]
  enabled = true
  label = "Email"
  url = "mailto:your@email.com"
  icon = "fa-solid fa-envelope"
  newTab = false
  imageURL = ""

[[params.footer.contacts]]
  enabled = true
  label = "WeChat"
  url = ""
  icon = "fa-brands fa-weixin"
  newTab = false
  imageURL = "/images/icons/wechat.png"
```

- `enabled`：是否显示该联系方式。
- `url`：点击地址；微信等无需点击时留空。
- `icon`：Font Awesome 图标类名。
- `newTab`：是否在新标签页打开。
- `imageURL`：悬停时显示的图片，可以填写站内路径或完整网络 URL；不需要图片时留空。

Footer 的标题、About Me、Teaching 链接及版权文字位于 `[params.footer]` 中。

### About Me 与我的文章

- 个人介绍：编辑 `content/about/_index.md`
- 我的文章：Markdown 文件同样直接放入 `content/about/`

新建一篇文章：

```bash
hugo new about/article-slug.md
```

需要在 About Me 中展示哪篇文章，就在 `_index.md` 里手动添加链接：

```markdown
[《xxxx》](/about/xxxx.md)
```

Hugo 构建时会把这个 Markdown 源文件地址转换为文章页面地址 `/about/xxxx/`。

---

## 中英文内容

中文是默认语言，继续使用原有地址；英文页面统一位于 `/en/`：

```text
/growth/article/       ← 中文
/en/growth/article/    ← 英文
```

英文稿与中文稿放在同一目录，并在文件名末尾加 `.en`：

```text
content/growth/article.md       ← 中文稿
content/growth/article.en.md    ← 英文稿
```

两份文件 basename 相同，Hugo 会自动将它们识别为互译页面，并在右上角显示
`EN` 或 `中文` 切换入口。只有中文稿、没有对应 `.en.md` 时：

- 中文站正常显示；
- 英文首页和栏目列表不显示；
- 中文文章页不显示 `EN` 切换入口。

栏目首页也可以成对创建：

```text
content/growth/_index.md
content/growth/_index.en.md
```

英文首页、栏目名称及按钮文案在 `hugo.toml` 的
`[languages.en.params...]` 中配置。新增栏目时，如需进入英文站，还要增加对应的
`[languages.en.params.sections.栏目名]` 配置以及至少一篇英文稿。

英文 About Me 使用 `content/about/_index.en.md`。在其中手动链接英文文章时，
链接到英文源文件：

```markdown
[“xxxx”](/about/xxxx.en.md)
```

构建后会自动转换为 `/en/about/xxxx/`。

---

## 部署上线

### 第一次部署

```bash
npm i -g vercel    # 安装 Vercel CLI（只需一次）
cd jiaphyper
vercel
```

Vercel 会问几个问题：
- Framework: **Hugo**
- Build command: **hugo**
- Output directory: **public**

### 之后每次更新

```bash
vercel --prod
```

### 绑定域名

1. Vercel 后台 → 你的项目 → Settings → Domains → 填入 `jiaphyper.com`
2. Vercel 给你两条 DNS 记录（A 记录 + CNAME）
3. 去 Namesilo → DNS 管理 → 填入这两条记录
4. 等 5–30 分钟生效

---

## 常见操作速查

| 操作 | 方法 |
|------|------|
| 新建成长文章 | `hugo new growth/slug.md` |
| 新建论文笔记 | `hugo new papers/slug.md` |
| 设为草稿（不发布） | `draft: true` |
| 插入本地图片 | 图片放 `static/images/`，用 `/images/xxx.jpg` 引用 |
| 行内数学公式 | `$公式$` |
| 独立数学公式 | `$$公式$$` |
| 更新微信二维码 | 修改 `hugo.toml` 中对应联系方式的 `imageURL` |
| 更新邮箱/X链接 | 修改 `hugo.toml` 中对应联系方式的 `url` |
| 本地预览 | `hugo server` |
| 发布上线 | `vercel --prod` |

function initializeSite() {

  // ── Light / dark theme ──────────────────────────────────────────
  const themeToggle = document.getElementById('themeToggle');
  const themeIcon = document.getElementById('themeIcon');

  function applyTheme(theme, persist = false) {
    const selectedTheme = theme === 'dark' ? 'dark' : 'light';
    document.documentElement.dataset.theme = selectedTheme;
    if (themeToggle) {
      const nextThemeLabel = selectedTheme === 'dark'
        ? themeToggle.dataset.lightLabel
        : themeToggle.dataset.darkLabel;
      themeToggle.setAttribute('aria-label', nextThemeLabel);
      themeToggle.setAttribute('title', nextThemeLabel);
    }
    if (themeIcon) {
      themeIcon.classList.toggle('fa-sun', selectedTheme === 'light');
      themeIcon.classList.toggle('fa-moon', selectedTheme === 'dark');
    }
    if (persist) {
      try {
        localStorage.setItem('jiaphyper-theme', selectedTheme);
      } catch (_) {
        // Theme still applies when browser storage is unavailable.
      }
    }
  }

  applyTheme(document.documentElement.dataset.theme);
  if (themeToggle) {
    themeToggle.addEventListener('click', () => {
      const nextTheme = document.documentElement.dataset.theme === 'dark' ? 'light' : 'dark';
      applyTheme(nextTheme, true);
    });
  }

  // ── Mobile nav toggle ───────────────────────────────────────────
  const menuBtn = document.getElementById('navMenuBtn');
  const mobileNav = document.getElementById('navMobile');
  if (menuBtn && mobileNav) {
    menuBtn.addEventListener('click', () => {
      mobileNav.classList.toggle('open');
    });
  }

  // ── Nabokov card filter ─────────────────────────────────────────
  const filterBtns = document.querySelectorAll('.filter-btn');
  const allCards   = document.querySelectorAll('#allCards .ncard');

  filterBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      filterBtns.forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      const type = btn.dataset.type;
      allCards.forEach(card => {
        const show = type === 'all' || card.dataset.type === type;
        card.style.display = show ? '' : 'none';
      });
    });
  });

  // ── Nabokov random draw ─────────────────────────────────────────
  const drawBtn    = document.getElementById('drawBtn');
  const drawAgain  = document.getElementById('drawAgain');
  const drawResult = document.getElementById('drawResult');
  const drawnCards = document.getElementById('drawnCards');

  function shuffle(arr) {
    const a = [...arr];
    for (let i = a.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [a[i], a[j]] = [a[j], a[i]];
    }
    return a;
  }

  function escapeHtml(value) {
    return String(value).replace(/[&<>"']/g, char => ({
      '&': '&amp;',
      '<': '&lt;',
      '>': '&gt;',
      '"': '&quot;',
      "'": '&#039;'
    })[char]);
  }

  function renderDrawnCards() {
    if (typeof allCardData === 'undefined' || !allCardData.length) return;

    const count = 3 + Math.floor(Math.random() * 3); // 3–5
    const picked = shuffle(allCardData).slice(0, count);
    const isEnglish = document.documentElement.lang.toLowerCase().startsWith('en');
    const typeLabels = isEnglish
      ? { quote: 'Quote', reflection: 'Reflection', paper: 'Paper', video: 'Video' }
      : { quote: '摘录', reflection: '感悟', paper: '论文', video: '视频' };

    drawnCards.innerHTML = picked.map(card => {
      const typeLabel = typeLabels[card.type] || (isEnglish ? 'Card' : '卡片');
      const tags = (card.tags || []).map(tag => {
        // Compatible with both the original string format and the current link object.
        const label = typeof tag === 'string' ? tag : (tag.label || '');
        return `<span class="ncard-tag">${escapeHtml(label)}</span>`;
      }).join('');
      return `
        <div class="ncard drawn">
          <div class="ncard-type">${typeLabel}</div>
          <blockquote class="ncard-quote">${escapeHtml(card.quote)}</blockquote>
          ${card.source ? `<cite class="ncard-source">— ${escapeHtml(card.source)}</cite>` : ''}
          <div class="ncard-footer">
            <span class="ncard-date">${card.date}</span>
            <div class="ncard-tags">${tags}</div>
          </div>
        </div>
      `;
    }).join('');

    drawResult.style.display = 'block';
    drawResult.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
  }

  if (drawBtn)   drawBtn.addEventListener('click', renderDrawnCards);
  if (drawAgain) drawAgain.addEventListener('click', renderDrawnCards);

}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initializeSite, { once: true });
} else {
  initializeSite();
}

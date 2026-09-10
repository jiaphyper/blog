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

}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initializeSite, { once: true });
} else {
  initializeSite();
}

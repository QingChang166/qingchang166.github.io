(() => {
  const tabs = Array.from(document.querySelectorAll(".skill-tab"));
  const panels = Array.from(document.querySelectorAll(".capability-panel"));

  if (!tabs.length || !panels.length) return;

  const activate = (skill) => {
    tabs.forEach((tab) => {
      const isActive = tab.dataset.skill === skill;
      tab.classList.toggle("is-active", isActive);
      tab.setAttribute("aria-selected", String(isActive));
    });

    panels.forEach((panel) => {
      const isActive = panel.dataset.skillPanel === skill;
      panel.classList.toggle("is-active", isActive);
      panel.hidden = !isActive;
    });
  };

  tabs.forEach((tab) => {
    tab.addEventListener("click", () => activate(tab.dataset.skill));
  });
})();

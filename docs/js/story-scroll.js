(() => {
  const storySteps = Array.from(document.querySelectorAll(".story-step"));
  const scrollySteps = Array.from(document.querySelectorAll(".scrolly-step"));
  const scrollyVisuals = Array.from(document.querySelectorAll(".scrolly-visual"));
  const progressItems = Array.from(document.querySelectorAll(".story-progress span"));

  if (!storySteps.length && !scrollySteps.length) return;

  const updateProgress = (index) => {
    progressItems.forEach((item, itemIndex) => {
      item.classList.toggle("is-visible", itemIndex <= index);
    });
  };

  const activateStoryStep = (step) => {
    step.classList.add("is-visible");
    const index = Number(step.dataset.step || 0);
    updateProgress(index);
  };

  const activateScrollyStep = (step) => {
    const index = Number(step.getAttribute("data-scrolly-step") || 0);

    scrollySteps.forEach((candidate) => {
      candidate.classList.toggle("is-active", candidate === step);
    });

    scrollyVisuals.forEach((visual) => {
      const visualIndex = Number(visual.getAttribute("data-scrolly-visual") || -1);
      const isActive = visualIndex === index;
      visual.classList.toggle("is-active", isActive);
      if (visual.hasAttribute("data-lightbox-src")) {
        visual.setAttribute("tabindex", isActive ? "0" : "-1");
      }
    });

    updateProgress(index);
  };

  if (!("IntersectionObserver" in window)) {
    storySteps.forEach(activateStoryStep);
    scrollySteps.forEach(activateScrollyStep);
    return;
  }

  if (scrollySteps.length) {
    activateScrollyStep(scrollySteps[0]);
  }

  const storyObserver = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) activateStoryStep(entry.target);
      });
    },
    { threshold: 0.35 }
  );

  const scrollyObserver = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) activateScrollyStep(entry.target);
      });
    },
    { rootMargin: "-34% 0px -42% 0px", threshold: 0 }
  );

  storySteps.forEach((step) => storyObserver.observe(step));
  scrollySteps.forEach((step) => scrollyObserver.observe(step));
})();

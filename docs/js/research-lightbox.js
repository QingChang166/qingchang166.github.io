(function () {
  const triggers = Array.from(document.querySelectorAll("[data-lightbox-src]"));

  if (!triggers.length) {
    return;
  }

  const lightbox = document.createElement("div");
  lightbox.className = "research-lightbox";
  lightbox.hidden = true;
  lightbox.innerHTML = `
    <div class="research-lightbox-panel" role="dialog" aria-modal="true" aria-label="Expanded research figure">
      <button class="research-lightbox-close" type="button" aria-label="Close expanded figure">Close</button>
      <img class="research-lightbox-image" src="" alt="">
    </div>
  `;

  document.body.appendChild(lightbox);

  const closeButton = lightbox.querySelector(".research-lightbox-close");
  const expandedImage = lightbox.querySelector(".research-lightbox-image");
  let activeTrigger = null;

  function openLightbox(trigger) {
    activeTrigger = trigger;
    expandedImage.src = trigger.dataset.lightboxSrc;
    expandedImage.alt = trigger.dataset.lightboxAlt || "";
    lightbox.hidden = false;
    document.body.classList.add("research-lightbox-open");
    closeButton.focus();
  }

  function closeLightbox() {
    lightbox.hidden = true;
    expandedImage.removeAttribute("src");
    document.body.classList.remove("research-lightbox-open");

    if (activeTrigger) {
      activeTrigger.focus();
      activeTrigger = null;
    }
  }

  triggers.forEach((trigger) => {
    trigger.addEventListener("click", () => openLightbox(trigger));
    trigger.addEventListener("keydown", (event) => {
      if (event.key === "Enter" || event.key === " ") {
        event.preventDefault();
        openLightbox(trigger);
      }
    });
  });

  closeButton.addEventListener("click", closeLightbox);

  lightbox.addEventListener("click", (event) => {
    if (event.target === lightbox) {
      closeLightbox();
    }
  });

  document.addEventListener("keydown", (event) => {
    if (event.key === "Escape" && !lightbox.hidden) {
      closeLightbox();
    }
  });
})();

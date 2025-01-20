document.addEventListener("DOMContentLoaded", function () {
  const textParts = [
    "Computational social scientist using big data and cutting-edge machine learning techniques to tackle critical political economy questions! ",
    { type: "link", content: "Learn more about me →", href: "/about.html" }
  ];
  const speed = 50; // Typing speed in milliseconds
  let currentPartIndex = 0;
  let currentCharIndex = 0;

  function typeWriter() {
    const element = document.getElementById("typewriter");

    if (currentPartIndex < textParts.length) {
      const currentPart = textParts[currentPartIndex];

      if (typeof currentPart === "string") {
        // Handle plain text
        if (currentCharIndex < currentPart.length) {
          element.innerHTML += currentPart.charAt(currentCharIndex);
          currentCharIndex++;
          setTimeout(typeWriter, speed);
        } else {
          currentCharIndex = 0;
          currentPartIndex++;
          typeWriter();
        }
      } else if (currentPart.type === "link") {
        // Handle link
        const link = document.createElement("a");
        link.className = "code-links";
        link.href = currentPart.href;
        link.textContent = currentPart.content;
        element.appendChild(link);

        currentPartIndex++;
        typeWriter();
      }
    }
  }

  typeWriter();
});
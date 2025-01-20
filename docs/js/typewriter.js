document.addEventListener("DOMContentLoaded", function () {
  const typewriterWords = [
    { id: "word1", content: "computational social scientist" },
    { id: "word2", content: "statistical learning" },
    { id: "word3", content: "large-scale data" },
    { id: "word4", content: "political economy." },
    { type: "link", content: "Learn more about me →", href: "/about.html" } // Add clickable link
  ]; // Words for typewriter effect

  const speed = 100; // Typing speed in milliseconds
  let currentWordIndex = 0;
  let currentCharIndex = 0;

  function typeWriter() {
    if (currentWordIndex < typewriterWords.length) {
      const currentWord = typewriterWords[currentWordIndex];

      if (currentWord.type === "link") {
        // Handle clickable link
        if (currentCharIndex === 0) {
          const link = document.createElement("a");
          link.className = "code-links";
          link.href = currentWord.href;
          link.target = "_blank"; // Open in a new tab
          link.textContent = ""; // Initialize with empty content
          document.getElementById("typewriter-effect").appendChild(link);
        }

        const linkElement = document.querySelector(".code-links");
        if (currentCharIndex < currentWord.content.length) {
          linkElement.textContent += currentWord.content.charAt(currentCharIndex);
          currentCharIndex++;
          setTimeout(typeWriter, speed);
        } else {
          currentCharIndex = 0;
          currentWordIndex++;
          typeWriter();
        }
      } else {
        // Handle regular words
        const element = document.getElementById(currentWord.id);

        if (currentCharIndex < currentWord.content.length) {
          element.innerHTML += currentWord.content.charAt(currentCharIndex);
          currentCharIndex++;
          setTimeout(typeWriter, speed);
        } else {
          currentCharIndex = 0;
          currentWordIndex++;
          typeWriter();
        }
      }
    }
  }

  // Start typewriter effect
  typeWriter();
});
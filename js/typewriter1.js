document.addEventListener("DOMContentLoaded", function () {
  const typewriterWords = [
    { id: "word1", content: "computational social scientist"},
    { id: "word2", content: "statistical learning"},
    { id: "word3", content: "large-scale data"},
    { id: "word4", content: "political economy"}
  ]; // Words for typewriter effect

  const speed = 100; // Typing speed in milliseconds
  let currentWordIndex = 0;
  let currentCharIndex = 0;

  function typeWriter() {
    if (currentWordIndex < typewriterWords.length) {
      const currentWord = typewriterWords[currentWordIndex];
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

  // Start typewriter effect
  typeWriter();
});
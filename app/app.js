window.addEventListener("load", async () => {
  const searchInput = document.querySelector("#search");
  const vscodes = [...document.querySelectorAll(".vscode").values()];
  searchInput.addEventListener("input", () => {
    vscodes
      .filter((link) => link.textContent.includes(searchInput.value))
      .forEach((link) => {
        link.style.display = "";
      });
    vscodes
      .filter((link) => !link.textContent.includes(searchInput.value))
      .forEach((link) => {
        link.style.display = "none";
      });
  });
});

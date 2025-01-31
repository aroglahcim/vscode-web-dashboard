(() => {
  let selectedIndex = -1;
  
  window.addEventListener("load", async () => {
    const searchInput = document.querySelector("#search");
    const vscodes = [...document.querySelectorAll(".vscode").values()];
    
    searchInput.addEventListener("input", () => {
      selectedIndex = -1;
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
    
    searchInput.addEventListener('focus', () => {
      searchInput.setSelectionRange(searchInput.value.length, searchInput.value.length);
      selectedIndex = -1;
    });
  });
  
  window.addEventListener("keydown", async (event) => {
    const searchInput = document.querySelector("#search");
    const vscodes = [...document.querySelectorAll(".vscode:not([style*=\"display: none\"])").values()];
    
    if (event.code === 'Escape') {
      searchInput.focus();
      
    } else if (event.code === 'ArrowDown') {
      selectedIndex = Math.min(selectedIndex + 1, vscodes.length - 1);
      vscodes.at(selectedIndex).focus();
      
    } else if (event.code === 'ArrowUp') {
      selectedIndex = Math.max(selectedIndex - 1, -1);
      if (selectedIndex === -1) {
        searchInput.focus();
      } else {
        vscodes.at(selectedIndex).focus();
      }
    }
  })
  
})();

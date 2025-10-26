// Auto-submit search form with debounce
document.addEventListener('turbo:load', () => {
  const searchInput = document.querySelector('.search-input');
  
  if (searchInput) {
    let debounceTimer;
    
    searchInput.addEventListener('input', (e) => {
      clearTimeout(debounceTimer);
      
      debounceTimer = setTimeout(() => {
        e.target.form.requestSubmit();
      }, 500); // Wait 500ms after user stops typing
    });
  }
});

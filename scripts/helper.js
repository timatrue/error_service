window.errorService = window.errorService || {};
window.errorService = (function(){
    function initListeners(button, form){
        button.addEventListener('click', toggleForm.bind(form));
        form.style.display = "none";
    }
    function toggleForm(){
        if (this.style.display === "none") {
            this.style.display = "block";
        } else {
            this.style.display = "none";
        }
    }
    return {
        initListeners : initListeners
    }
})();


console.log("JavaScript loaded!");

let modal = document.querySelectorAll("#footer-pg");

for(let i = 0; i < modal.length; i++){
  modal[i].addEventListener("click", display);
  console.log(modal[i]);

  function display() {
    var mod = modal[i].nextElementSibling;
    console.log(mod);
    mod.classList.remove("hidden")
  }
}

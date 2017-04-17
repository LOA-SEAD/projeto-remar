
window.onload = function() {
  $('.modal').modal();
  $('.grid').masonry({
    itemSelector: '.grid-item'
  });
}

$(document).ready(function() {
  $('.grid').masonry('layout');
});

// Normaliza espaços em branco de códigos mostrados dentro de blocos PrismJS
Prism.plugins.NormalizeWhitespace.setDefaults({
  'remove-trailing': true,
  'remove-indent': true,
  'left-trim': true,
  'right-trim': true
});



$(document).ready(function() {
  $('.modal').modal();
});

// Normaliza espaços em branco de códigos mostrados dentro de blocos PrismJS
Prism.plugins.NormalizeWhitespace.setDefaults({
  'remove-trailing': true,
  'remove-indent': true,
  'left-trim': true,
  'right-trim': true
});

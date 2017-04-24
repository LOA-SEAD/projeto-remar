// Created by Pedro Garcia
// 04-12-2017

$(document).ready(function() {
  console.log('document ready');

  // Materialize Stuff
  var $modal = $('.modal').modal();

  $('input.autocomplete').autocomplete({
    data: {
      "Cores": null,
      "Botões": null,
      "Modal": null,
      "Formulário": null
    },
    limit: 20,
    onAutocomplete: function(val) {
      // Callback function when value is autcompleted.
    },
    minLength: 1
  });

  console.log('materialize loaded');

  // Sticky Kit
  $('.navbox-container').stick_in_parent();
  console.log('Sticky Kit loaded');

  // Smooth Scrolling
  $('.nav-btn a').on('click', function() {
    var scrollto = $($(this).attr('href')).top - $navbarHeight;
    $('html body').animate({
      scrollTop: scrollto
    }, 800);
  });
});

// Normaliza espaços em branco de códigos mostrados dentro de blocos PrismJS
Prism.plugins.NormalizeWhitespace.setDefaults({
  'remove-trailing': true,
  'remove-indent': true,
  'left-trim': true,
  'right-trim': true
});

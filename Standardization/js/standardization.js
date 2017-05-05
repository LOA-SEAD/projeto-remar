// Created by Pedro Garcia
// 04-12-2017

$(document).ready(function() {
  console.log('document ready');

  var $topMargin = -20;
  var $topOffset = $('#components nav').height() + $topMargin

  loadMaterialize();
  loadStickyKit();
  loadWaypoint($topOffset);

  // Smooth Scrolling
  $('.navbtn').click(function() {
    var $hrefPos = $( $(this).attr('href') ).offset().top;
    var $scrollPos = $hrefPos - $topOffset;

    // Toggle Active Button
    $('#components nav ul .active').removeClass('active');
    $(this).closest('li').addClass('active');

    // Animate
    $('html, body').animate({
        scrollTop: $scrollPos
    }, 1500);
  });
});

// Normalizes PrismJS codeboxes whitespaces
Prism.plugins.NormalizeWhitespace.setDefaults({
  'remove-trailing': true,
  'remove-indent': true,
  'left-trim': true,
  'right-trim': true
});

// Load Materialize
function loadMaterialize() {
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
}

// Load Sticky Kit
function loadStickyKit() {
  $('#components nav').stick_in_parent()
    .on('sticky_kit:unstick', function(e) {
      // If unsticks, it means that we hit page top, so deactivate all buttons
      $('#components nav ul .active').removeClass('active');
    });
  console.log('sticky kit loaded');
}

// Load Waypoint
function loadWaypoint(topOffset) {
  var $waypoints = $('div[id ^= "panel--"]');

  // When a card-panel component is scrolled downwards
  $waypoints.waypoint (function(direction) {
    if (direction === 'down') {
      var $element = $(this.element);
      var $relativeUrl = '#' + $($element).attr('id');
      var $relativeButton = $('a[href="' + $relativeUrl + '"]');

      // Toggle Active Button
      $('#components nav ul .active').removeClass('active');
      $($relativeButton).closest('li').addClass('active');
    }
  }, {
    offset: topOffset
  });

  // When a card-panel component is scrolled upwards
  $waypoints.waypoint (function(direction) {
    if (direction === 'up') {
      var $element = $(this.element);
      var $relativeUrl = '#' + $($element).attr('id');
      var $relativeButton = $('a[href="' + $relativeUrl + '"]');

      // Toggle Active Button
      $('#components nav ul .active').removeClass('active');
      $($relativeButton).closest('li').addClass('active');
    }
  }, {
    offset: function () {
      return -this.element.clientHeight * 0.5
    }
  });

  console.log ('waypoint loaded')
}

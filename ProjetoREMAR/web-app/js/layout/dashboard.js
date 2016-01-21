/**
 * Created by matheus on 10/8/15.
 */

$(document).ready(function() {
   //$('#button-collapse').sideNav();

   console.log(window.innerWidth);

   if(window.innerWidth > 992) { //desktop
      $('#slick').slick({
         infinite: true,
         slidesToShow: 4,
         slidesToScroll: 1,
         autoplay: true,
         autoplaySpeed: 2500,
         dots: true,
         //centerMode: true,
         adaptiveHeight: true,
         focusOnSelect: true,
         mobileFirst: true
      }).css({"width":"725px", "margin-left": "35px"});


   }else if(window.innerWidth <= 992 && window.innerWidth > 600){ //tablet
      $('#slick').slick({
         infinite: true,
         slidesToShow: 3,
         slidesToScroll: 1,
         autoplay: true,
         autoplaySpeed: 2500,
         dots: true,
         //centerMode: true,
         adaptiveHeight: true,
         focusOnSelect: true,
         mobileFirst: true
      }).css({"width":"550px", "margin": "0 auto"});
   }else{ //mobile
      $('#slick').slick({
         infinite: true,
         slidesToShow: 2,
         slidesToScroll: 1,
         autoplay: true,
         autoplaySpeed: 2500,
         dots: true,
         adaptiveHeight: true,
         focusOnSelect: true,
         mobileFirst: true
      }).css({"width":"350px", "margin": "0 auto"});
   }


   //
   //$( window ).resize(function() {
   //
   //   if(window.innerWidth > 992) { //desktop
   //      $('#slick').slick({
   //         infinite: true,
   //         slidesToShow: 4,
   //         slidesToScroll: 1,
   //         autoplay: true,
   //         autoplaySpeed: 2500,
   //         dots: true,
   //         //centerMode: true,
   //         adaptiveHeight: true,
   //         focusOnSelect: true,
   //         mobileFirst: true
   //      });
   //   }else if(window.innerWidth <= 992){ //tablet
   //      $('#slick').slick({
   //         infinite: true,
   //         slidesToShow: 3,
   //         slidesToScroll: 1,
   //         autoplay: true,
   //         autoplaySpeed: 2500,
   //         dots: true,
   //         //centerMode: true,
   //         adaptiveHeight: true,
   //         focusOnSelect: true,
   //         mobileFirst: true
   //      });
   //   }else if(window.innerWidth <= 600){ //mobile
   //      $('#slick').slick({
   //         infinite: true,
   //         slidesToShow: 2,
   //         slidesToScroll: 1,
   //         autoplay: true,
   //         autoplaySpeed: 2500,
   //         dots: true,
   //         //centerMode: true,
   //         adaptiveHeight: true,
   //         focusOnSelect: true,
   //         mobileFirst: true
   //      });
   //   }
   //});


   //
   //$('.dropdown-button').dropdown({
   //       inDuration: 300,
   //       outDuration: 225,
   //       constrain_width: false, // Does not change width of dropdown to that of the activator
   //       hover: true, // Activate on hover
   //       gutter: 0, // Spacing from edge
   //       belowOrigin: false // Displays dropdown below the button
   //       //alignment: 'center' // Displays dropdown with edge aligned to the left of button
   //    }
   //);
});
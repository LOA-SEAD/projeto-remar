/**
 * Created by matheus on 10/8/15.
 */

$(document).ready(function() {
   //$('#button-collapse').sideNav();

   $('.rating-dashboard').each(function() {
      $(this).rateYo({
         readOnly: true,
         precision: 0,
         maxValue: 100,
         starWidth: "13px",
         rating: Number($(this).attr("data-stars"))
      });
   });

   //
   //if(window.innerWidth > 992) { //desktop
   //   $('.slick').slick({
   //      infinite: true,
   //      slidesToShow: 4,
   //      slidesToScroll: 1,
   //      autoplay: true,
   //      autoplaySpeed: 2500,
   //      dots: true,
   //      //centerMode: true,
   //      adaptiveHeight: true,
   //      focusOnSelect: true,
   //      mobileFirst: true,
   //      outline: none
   //   }).css({"width":"725px", "margin-left": "35px"});
   //
   //
   //}else if(window.innerWidth <= 992 && window.innerWidth > 600){ //tablet
   //   $('.slick').slick({
   //      infinite: true,
   //      slidesToShow: 3,
   //      slidesToScroll: 1,
   //      autoplay: true,
   //      autoplaySpeed: 2500,
   //      dots: true,
   //      //centerMode: true,
   //      adaptiveHeight: true,
   //      focusOnSelect: true,
   //      mobileFirst: true,
   //      outline: none
   //   }).css({"width":"550px", "margin": "0 auto"});
   //}else{ //mobile
   //   $('.slick').slick({
   //      infinite: true,
   //      slidesToShow: 2,
   //      slidesToScroll: 1,
   //      autoplay: true,
   //      autoplaySpeed: 2500,
   //      dots: true,
   //      adaptiveHeight: true,
   //      focusOnSelect: true,
   //      mobileFirst: true,
   //      outline: none
   //   }).css({"width":"350px", "margin": "0 auto"});
   //}




});

function startWizard(){
   if(window.innerWidth > 992) { //desktop
      introJs().start();
   }
}

window.onload = function(){
   var firstAccess = document.getElementById("userFirstAccessLabel").value;
   console.log(firstAccess);
   if(firstAccess=="true") {

      startWizard();

      $.ajax({
         url: '/user/setFalseFirstAccess',
         type: 'POST',
         success: function () {
            console.log("Sucess!");
            //your success code
         },
         error: function (XMLHttpRequest, textStatus, errorThrown) {
            //your error code
            console.log(textStatus + "\n" + errorThrown);
         }
      });
   }
};
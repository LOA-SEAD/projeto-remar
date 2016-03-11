/**
 * Created by lucasbocanegra on 03/03/16.
 */

$(document).ready(function(){

    var r = 0;
    var mainStars = $('#rateYo-main');

    $('.slider').slider('start');
    $('.modal-trigger').leanModal();

    $("#rateYo").rateYo({
        precision: 0,
        maxValue: 100,
        onChange: function (rating, rateYoInstance) {

            $(this).next().text(rating);
            r = rating
        }
    });


    $(mainStars).rateYo({
        readOnly: true,
        precision: 0,
        maxValue: 100,
        starWidth: "18px",
        rating: $(mainStars).attr("data-stars")
    });

    $(".modal-action").on("click", function(){

        var formData = new FormData();
        formData.append('stars',$(".counter").text());
        formData.append('comment', $("#comment-area").val());

        console.log('stars',$("#comment-area").val());

        $.ajax({
            url: "/resource/saveRating/" + $("#hidden").val(),
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                 response.rating = response.rating[0];
                 response.rating.user = response.rating.user[0];

                 console.log(response.rating);
                 console.log($("#comment").val());

                  $(".collection.rating").prepend(
                      '<li class="collection-item avatar">'+
                           '<img src="/data/users/'+response.rating.user.username+'/profile-picture" alt="'+response.rating.user.firstName+'" class="circle">'+
                           '<p class="title">'+response.rating.user.firstName+'<small> - '+ new Date(response.rating.date).getHours()+':'+ new Date(response.rating.date).getMinutes() +'</small></p>'+
                           '<p>'+response.rating.comment+'</p>'+
                           //'<p class="secondary-content">'+
                                '<div id="rateYo'+response.rating.id+'" class="secondary-content" style="display: inline-block;"></div>'+
                            //'</p>'+
                        '</li>'
                  );

                 $('#rateYo'+response.rating.id).rateYo({
                     readOnly: true,
                     precision: 0,
                     maxValue: 100,
                     starWidth: "15px",
                     rating: Number(response.rating.stars)
                 });

                //var medium = (Number($(mainStars).attr("data-stars")) + Number(response.stars))/( Number($("#users").text()) + 1);
                //console.log(Number(medium));
                $(mainStars).rateYo("option","rating",response.rating.mediumStars);

                $("#comment-area").val("");
                $("#rateYo").rateYo("option","rating",0).next().text("0");

                $("#not-comment").hide();
            },
            error: function () {
                alert("error");
            }
        });
    });

    $('.rating-stars').each(function() {
        $(this).rateYo({
            readOnly: true,
            precision: 0,
            maxValue: 100,
            starWidth: "15px",
            rating: Number($(this).attr("data-stars"))
        });
    });

});

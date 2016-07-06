/**
 * Created by lucasbocanegra on 03/03/16.
 */

$(document).ready(function(){

    var current_rating = null;
    var r = 0;
    var mainStars = $('#rateYo-main');

    $(".dropdown-button").dropdown({
        inDuration: 300,
        outDuration: 0,
        constrain_width: true, // Does not change width of dropdown to that of the activator
        hover: false, // Activate on hover
        gutter: 0, // Spacing from edge
        belowOrigin: true, // Displays dropdown below the button
        alignment: 'left' // Displays dropdown with edge aligned to the left of button
    });

    $("#comment-error").hide();
    $(".counter").text(0);

    $("#comment-area").focus(function(){
        $("#comment-error").hide();
    });

    $('.slider').slider();
    $('.modal-trigger').leanModal({
        complete: function() { $(".lean-overlay").remove(); }
    });

    $("#rateYo").rateYo({
        precision: 0,
        maxValue: 100,
        halfStar: true,
        onChange: function (rating, rateYoInstance) {

            $(this).next().text(rating / 10);
            r = rating /10
        }
    });

    $(mainStars).rateYo({
        readOnly: true,
        precision: 0,
        maxValue: 100,
        starWidth: "18px",
        rating: $(mainStars).attr("data-stars")
    });

    $("#create-rating").on("click", function(){

        if($("#comment-area").val()==""){
            var fildComment = document.getElementById('comment-area');
            $("#comment-error").show();
            $("#comment-area").addClass("invalid");

        }
        else{
            var formData = new FormData();
            formData.append('stars',Number($(".counter").text())*10);
            formData.append('commentRating', $("#comment-area").val());

            $.ajax({
                url: "/resource/saveRating/" + $("#hidden").val(),
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function (response) {

                    $(".collection.rating").prepend(response);

                    var rating = $(response).find(".rating-stars");

                    $('#rateYo'+rating.attr("data-rating-id")).rateYo({
                        readOnly: true,
                        precision: 0,
                        maxValue: 100,
                        starWidth: "15px",
                        rating: Number(rating.attr("data-stars"))
                    });

                    $(mainStars).rateYo("option","rating",rating.attr("data-medium-stars"));

                    $("#comment-area").val("");
                    $("#rateYo").rateYo("option","rating",0).next().text("0");

                    $("#users").text("("+rating.attr("data-sum-users")+")");

                    $(".dropdown-button").dropdown();
                    $(".edit-rating").on('click',setListenerEdit);
                    //$(".delete-rating").on('click',setListenerDelete);

                    $("#not-comment").hide();
                    $("#modal-comment").closeModal();
                    $(".lean-overlay").remove();
                },
                error: function () {
                    alert("error");
                }
            });
        }
    });

    $('.rating-stars').each(function() {
        $(this).rateYo({
            readOnly: true,
            precision: 0,
            maxValue: 100,
            starWidth: "15px",
            halfStar: true,
            rating: Number($(this).attr("data-stars"))
        });

        $(this).next(".stars-font").text("("+($(this).attr("data-stars")/10)+")");
    });

    //classe nos botões edit e delete rating
    $(".edit-rating").on("click",setListenerEdit);

    //$(".delete-rating").on("click",setListenerDelete);


    //botão do modal de editar
    $("#edit-rating").on("click",function(){

        var parent = $(current_rating).parents().eq(2);
        var stars = Number(parent.find(".rating-stars").attr("data-stars"));
        var commentArea = $("#comment-area");

        if($(commentArea).val()==""){
            var fildComment = document.getElementById('comment-area');
            $("#comment-error").show();
            $(commentArea).addClass("invalid");
        }
        else{
            var formData = new FormData();
            formData.append('stars',Number($(".counter").text())*10);
            formData.append('comment', $(commentArea).val());

            $.ajax({
                url: "/resource/updateRating/" + $(current_rating).attr("id-rating"),
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function (response) {
                    $('#modal1').closeModal();
                    $("#create-rating").show();
                    $('#edit-rating').hide();

                    parent.remove();

                    $(".collection.rating").prepend(response);

                    var rating = $(response).find(".rating-stars");

                    $('#rateYo'+rating.attr("data-rating-id")).rateYo({
                        readOnly: true,
                        precision: 0,
                        maxValue: 100,
                        starWidth: "15px",
                        rating: Number(rating.attr("data-stars"))
                    });

                    //set medium stars and amount users of resource
                    $(mainStars).rateYo("option","rating",rating.attr("data-medium-stars"));
                    $("#users").text("("+rating.attr("data-sum-users")+")");

                    //start field (zero) of modal
                    $(commentArea).val("").next().removeClass("active").before().removeClass("active");
                    $("#rateYo").rateYo("option","rating",0).next().text(0);

                    $(".dropdown-button").dropdown();
                    $(".edit-rating").on('click',setListenerEdit);
                    //$(".delete-rating").on('click',setListenerDelete);

                    $("#not-comment").hide();
                    $("#modal-comment").closeModal();
                    $(".lean-overlay").remove();

                    current_rating = null; //reset current rating

                    Materialize.toast('Comentário editado!', 3000, 'rounded');

                },
                error: function () {
                    alert("error");
                }
            });
        }
    }).hide();


    function setListenerEdit(){
        var parent = $(this).parents().eq(2);
        var stars = Number(parent.find(".rating-stars").attr("data-stars"));
        var commentArea = $("#comment-area");

        $('#modal-comment').openModal();

        $("#create-rating").hide();
        $('#edit-rating').show();

        $(commentArea).val(parent.find(".rating-desc").text()).next().addClass("active").before().addClass("active");
        $("#rateYo").rateYo("option","rating",stars).next().text(stars / 10);

        current_rating = $(this); //set current rating clicked
    }

});

function deleteRating(id){
    var parent = $(this).parents().eq(2);
    var idRating = Number(parent.find(".rating-stars").attr("data-rating-id"));

    $.ajax({
        url: "/resource/deleteRating/",
        type: 'GET',
        data: {id: id},
        success: function (response) {
            if(response!="null") {
                $("#rating" + id).remove();
                $("#users").text("(" + response.sumUser + ")");

                //set medium stars and amount users of resource
                var n = Number(response.sumStars) / Number(response.sumUser);
                $("#rateYo-main").rateYo("option", "rating", n);

                Materialize.toast('Comentário excluído!', 3000, 'rounded');
            }
        },
        error: function () {
            alert("error");
        }
    });
}
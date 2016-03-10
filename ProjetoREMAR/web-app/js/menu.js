/**
 * Created by lucas on 22/01/16.
 */

$(document).ready(function() {
    var select = $("select");

    $(select).material_select();

    $("#search").keyup(function(){
        _this = this;

        $.each($(".card ").find(".card-name"), function() {
            //console.log($(this).text());
            if($(this).text().toLowerCase().indexOf($(_this).val().toLowerCase()) == -1)
                $(this).closest('div[class^="card square-cover small"]').hide(500);
            else
                $(this).closest('div[class^="card square-cover small"]').show(500);
                //Materialize.fadeInImage($(this).closest('div[class^="card square-cover small"]'));
        });
    });

    $(select).change(function(){
        //console.log($(".card ").find(".card-name").attr('data-category'));
        var catSelected = $(select).val();

        $.each($(".card ").find(".card-name"), function() {
            //console.log($(this).text());
            console.log($(this).attr('data-category'));

            if(catSelected == -1){
                $(this).closest('div[class^="card square-cover small"]').show(500);
            }else if($(this).attr('data-category') != catSelected){
                        $(this).closest('div[class^="card square-cover small"]').hide(500);
            }else {
                $(this).closest('div[class^="card square-cover small"]').show(500);
            }
            //Materialize.fadeInImage($(this).closest('div[class^="card square-cover small"]'));
        });


    });
});
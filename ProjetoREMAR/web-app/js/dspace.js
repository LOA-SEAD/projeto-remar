/**
 * Created by lucasbocanegra on 21/06/16.
 */

document.window.ready(function(){

    $(".collection-link").on("click",function(){
        var formData = new FormData();
        formData.append('name',$(this).text());
        console.log($(this).text());

        $.ajax({
            type: 'POST',
            url: location.origin + "/dspace/listCollection/",
            data: formData,
            processData: false,
            contentType: false,
            success: function (data) {
                console.log(data);
            },
            error: function(req, res, err) {
                console.log(req);
                console.log(res);
                console.log(err);
            }
        });



    });

});
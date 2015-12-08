/**
 * Created by matheus on 6/27/15.
 */


window.onload = function(){
    $('.review').on('click', function() {
        var id = $(this).data('id');
        var status = $(this).data('review');
        var _this = this;
        var img = $(this).parents().eq(5).find('img');
        var imgSrc = $(img).attr('src');
        console.log(imgSrc);

        $(img).attr('src', '/images/loading_spinner.gif');

        var url = location.origin + '/resource/review/' + id + "/" + status;

        $.ajax({
            type:'POST',
            url: url,
            success:function(data){
                console.log(data);
                var tr = $(_this).parents().eq(4);
                $(tr).removeClass('red yellow darken-1 green');
                if (status == 'approve') {
                    $(tr).addClass('green');
                } else {
                    $(tr).addClass('red');
                }
                $(img).attr('src', imgSrc);

            },
            error:function(req, status, err){
                console.log(req.responseText);
                $(img).attr('src', imgSrc);
            }});
    });

    $('.comment').on('focusout', function() {
        var url = location.origin + '/resource/review/' + $(this).data('id') + "?comment=" + encodeURIComponent($(this).val());
        $.ajax({
            type:'POST',
            url: url,
            success:function(data){
                console.log(data);
            },
            error:function(XMLHttpRequest,textStatus,errorThrown){}});
    });

    $('.comment').keyup(function(e) {
        if (e.keyCode == 13) {
            $(this).blur();
        }
    });

    $('.delete').on('click', function() {
        var el = $(this);
        var id = $(this).data('id');

        $.ajax({
            type: 'DELETE',
            url: location.origin + '/resource/delete/' + id,
            success: function(data) {
                console.log(data);
                console.log($(el).parents().eq(5).remove());
            },
            error: function(req, status, err) {
                console.log(req.responseText);
            }
        })
    });


};


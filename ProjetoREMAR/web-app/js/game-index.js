/**
 * Created by matheus on 6/27/15.
 */


window.onload = function(){
    $('.review').on('click', function() {
        var id = $(this).data('id');
        var status = $(this).data('review');
        var _this = this;


        var url = location.origin + '/game/review/' + id + "/" + status;


        $.ajax({
            type:'POST',
            url: url,
            success:function(data){
                console.log(data);
                var tr = $(_this).parents().eq(5);
                $(tr).removeClass('panel-red panel-yellow pannel-green');
                if (status == 'approve') {
                    $(tr).addClass('panel-green');
                } else {
                    $(tr).addClass('panel-red');
                }

            },
            error:function(XMLHttpRequest,textStatus,errorThrown){}});
    });

    $('.comment').on('focusout', function() {
        var url = location.origin + '/game/review/' + $(this).data('id') + "?comment=" + encodeURIComponent($(this).val());
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


};


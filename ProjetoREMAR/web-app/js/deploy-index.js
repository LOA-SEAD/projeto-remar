/**
 * Created by matheus on 6/27/15.
 */


window.onload = function(){
    $('.review').on('click', function() {
        var id = $(this).data('id');
        var status = $(this).data('review');
        var _this = this;


        var url = location.origin + '/deploy/review/' + id + "/" + status;


        $.ajax({
            type:'POST',
            url: url,
            success:function(data){
                console.log(data);
                var tr = $(_this).parents().eq(4);
                $(tr).removeClass('warning success danger');
                if (status == 'approve') {
                    $(tr).addClass('success');
                } else {
                    $(tr).addClass('danger');
                }

            },
            error:function(XMLHttpRequest,textStatus,errorThrown){}});
    });

    $('.comment').on('focusout', function() {
        var url = location.origin + '/deploy/review/' + $(this).data('id') + "?comment=" + encodeURIComponent($(this).val());
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


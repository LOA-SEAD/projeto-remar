/**
 * Created by lucas on 22/01/16.
 */

$(document).ready(function() {

    $('.rating-card').each(function() {
        $(this).rateYo({
            readOnly: true,
            precision: 0,
            maxValue: 100,
            starWidth: "13px",
            rating: Number($(this).attr("data-stars"))
        });
    });
});

function deleteResource(id, processID){
    //console.log(id);
    //console.log(processID);
    if(confirm("Deseja mesmo excluir este jogo?")){
        window.location.href = " /exported-resource/delete?id="+id+"&processId="+processID;
    }
}


// This is a functions that scrolls to #{blah}link
function goToByScroll(id){
    // Remove "link" from the ID
    id = id.replace("link", "");
    // Scroll
    $('html,body').animate({
            scrollTop: $("#"+id).offset().top},
        'slow');
}
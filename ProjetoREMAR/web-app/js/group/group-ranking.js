/*
 * Created by Pedro Garcia (github: garcia-pedro-hr)
 *  on Jun 29, 2017
 *
 * This file manages user ranking of a group
 */

$(document).ready(function() {
    console.log ('group-ranking.js loaded');

    $('#ranking a.btn').click(function() {
        var ID = $('#group-id').val();
        var URL = '/group/rankUsers';

        console.log(ID);

        $.ajax ({
            type: 'GET',
            url: URL,
            data: {id: ID},
            success: function (resp) {
                console.log(resp);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log(errorThrown);
            }
        });
    });
});

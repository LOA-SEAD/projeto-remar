/**
 * Created by garciaph on 24/07/17.
 */

var DELETE_URL = "/quimolecula/molecule/delete";
var SEND_URL= "/quimolecula/molecule/send";

$(document).ready(function () {

    $('.sortable')
        .on('click', 'li', function() {
            $(this).toggleClass('active');

            // Specific behaviour of available molecules list
            if ($(this).closest('ul').attr('id') == 'available-molecules') {
                var $button = $('#' + $(this).parent().data('button'));

                // If any available molecules are selected, enable the delete button
                if ($('#available-molecules li.active').length >= 1) {
                    $button.removeClass('disabled');
                } else {
                    $button.addClass('disabled');
                }
            }
        })
        .sortable({
            connectWith: '.sortable',
            delay: 150, // needed to prevent accidental drag when trying to select

            helper: function (e, item) {
                // If you grab an unhighlighted item to drag, it will deselect (unhighlight) everything else
                if (!item.hasClass('active')) {
                    item.addClass('active').siblings().removeClass('active');
                }

                // Passing the selected items to the stop() function
                // Clone the selected items into an array
                var elements = item.parent().children('.active').clone().removeClass('active');

                // Add a property to 'item' called 'multidrag' that contains the selected items
                // Then remove the selected items from source list
                item.data('multidrag', elements).siblings('.active').remove();

                // Now the selected items exist in memory, attached to the 'item'
                // We can access them later when we get the stop() callback

                item.unbind('mouseenter mouseleave');

                // Create the helper
                var helper = $('<div/>');
                return helper.append(elements);
            },
            start: function (e, ui) {
                // Resize placeholder to the size of the objects being dragged
                var height = ui.item.outerHeight();
                var length = ui.item.data('multidrag').length;
                ui.placeholder.outerHeight((height - 0.5) * length);

                // To avoid bugs regarding the remove button, we disable it after dropping the element
                $('#deleteMoleculeButton').addClass('disabled');
            },
            stop: function (e, ui) {
                // Now we access those items that we stored in items data
                var elements = ui.item.data('multidrag');

                // 'elements' now contains the originally selected items from the source list

                // Finally, insert the selected items after the 'item', then remove the 'item'
                //      since item is a duplicate of one of the selected items
                ui.item.after(elements).remove();

                // Initialize tooltip of dinamically generated tooltips
                $('.tooltipped').tooltip();
            },
            update: function() {
                var button = '#' + $(this).data('button');
                // Specific behaviour for each of the sortable lists
                if($(this).attr('id') == 'available-molecules') {
                    // Disable the remove button for the available molecules list because user could have
                    // only one molecule in the list and, if it were selected, the button would be enabled
                    if ($(this).children().length <= 0) {
                        $(button).addClass('disabled');
                    }
                } else if ($(this).attr('id') == 'selected-molecules') {
                    // If the number of selected molecules is less or equal zero, disable the send button
                    // thus preventing the user from sending empty data
                    if ($(this).children().length <= 0) {
                        $(button).addClass('disabled');
                    } else if ($(this).children().length = 1) {
                        // If the list has one child after the end of the drag-and-drop event, it means
                        // that the user wants to send at least one molecule. So we enable the button.
                        $(button).removeClass('disabled');
                    }
                }
            }
        });

    $("#sendMoleculeButton").click(function() {
        var selectedMolecules = $("#selected-molecules li").map(function() {
            return $(this).data("moleculeId");
        });

        var data = { "id": selectedMolecules.toArray() };
        $.ajax({
            type: 'POST',
            url: SEND_URL,
            data: data,
            success: function(response) {
                window.top.location.href = response;
            },
            error: function(xhr, error, exThrown) {
                Materialize.toast("Ocorreu um erro! Tente novamente.");
                console.log("Response object: " + xhr);
                console.log("Error message: " + error);
                console.log("Exception: " + exThrown);
            }
        })
    });

    // Delete button click function
    $("#deleteMoleculeButton").click(function() {
        if (!($(this).hasClass('disabled'))) {
            // Capture each selected molecule item.
            $(".molecule-list-box li.active").each(function(){
                // Set
                var deleteData = {};
                deleteData.id = $(this).data("moleculeId");
                deleteData.ownerId = $(this).data("ownerId");
                deleteData._method = "DELETE";

                $.ajax({
                    type:"DELETE",
                    url: DELETE_URL + "/" + deleteData.id,
                    data: deleteData,
                    success: function(response) {
                        console.log("Molecula removida com sucesso.");
                        console.log(response);
                        window.location.reload(true);
                    },
                    error: function(error) {
                        console.log("Um erro ocorreu.");
                        console.log(error);
                    }
                });
            });
        }
    });
});



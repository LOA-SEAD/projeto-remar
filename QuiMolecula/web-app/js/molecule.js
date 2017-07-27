/**
 * Created by garciaph on 24/07/17.
 */

var DELETE_URL = "/quimolecula/molecule/delete";

$(document).ready(function () {

    $('.sortable')
        .on('click', 'li', function() {
            $(this).toggleClass('active');

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
                // TODO: Encontrar uma maneira melhor de pegar a altura correta do objeto do que uma solução hard-coded
                // ui.item.outerHeight() retorna 40 por algum motivo
                // Resize placeholder to the size of the objects being dragged
                var height = ui.item.outerHeight();
                var length = ui.item.data('multidrag').length;
                ui.placeholder.height(height * length);

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

    // Delete button click function
    $("#deleteMoleculeButton").click(function() {
        if (!($(this).hasClass('disabled'))) {
            $(".molecule-list-box li.active").each(function(){
                var deleteData = {};
                deleteData.id = $(this).data("moleculeId");
                deleteData.ownerId = $(this).data("ownerId");
                deleteData._method = "DELETE"

                $.ajax({
                    type:"DELETE",
                    url: DELETE_URL + "/" + deleteData.id,
                    data: deleteData,
                    success: function(response) {
                        console.log("Molecula removida com sucesso.");
                        console.log(response);
                    },
                    error: function(error) {
                        console.log("Um erro ocorreu.");
                        console.log(error);
                    }
                });
            });
            window.location.reload(true);
        }
    });
});



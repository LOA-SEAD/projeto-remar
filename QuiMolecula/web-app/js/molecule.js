/**
 * Last Update: 28/07/17.
 * Created by: Pedro Garcia on 24/07/17.
 * Authors: Pedro Garcia,
 *          Lucas Yuji Suguinoshita.
**/

// Server URLs used by this script;
var DELETE_URL = "/quimolecula/molecule/delete";
var SEND_URL= "/quimolecula/molecule/send";

// Interface messages used as feedback to user.
var SELECT_MOLECULE_MSG         = "Por favor selecione pelo menos uma molécula.";
var MAX_MOLECULE_REACHED_MSG    = "Por favor selecione menos moléculas!";
var REMOVE_SUCCESS_MSG          = "Molecula removida com sucesso.";
var ERROR_MSG                   = "Ocorreu um erro! Tente novamente.";

// Constants used by this script.
var MIN_MOLECULE_COUNT = 1;
var MAX_MOLECULE_COUNT = 20;
var TOAST_LIFESPAN_MILLI = 4000;

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
                    // If the number of selected molecules is less than the minimum or more than the maximum, disable the send button
                    // thus preventing the user from finishing the task
                    if ($(this).children().length < MIN_MOLECULE_COUNT || $(this).children().length > MAX_MOLECULE_COUNT) {
                        $(button).addClass('disabled');
                    } else if ($(this).children().length = MIN_MOLECULE_COUNT || $(this).children().length == MAX_MOLECULE_COUNT) {
                        // If the list has the minimum or maximum number of childs after the end of the drag-and-drop event, it means
                        // that the user has reached the possible number of molecules to send. So we enable the button.
                        $(button).removeClass('disabled');
                    }
                }
            }
        });

    // Finish molecule selection button click function
    $("#sendMoleculeButton").click(function() {
        // Capture all molecules dragged to the selected molecules list and extracter the molecule id
        var selectedMolecules = $("#selected-molecules li").map(function() {
            return $(this).data("moleculeId");
        });

        if (!($(this).hasClass('disabled'))) {
            // Setup the id list as a JSON object to be sent
            // Grails receives the list in a single parameter that'll be called "id[]"
            var data = { "id": selectedMolecules.toArray() };

            // Perform an AJAX request sending the molecule id list
            $.ajax({
                type: 'POST',
                url: SEND_URL,
                data: data,
                success: function(response) {
                    // The server returns a URL to redirect the user to.
                    // This page is supposed to be running in an iframe, so we use window.top to redirect the top/parent frame instead of the iframe.
                    window.top.location.href = response;
                },
                error: function(xhr, error, exThrown) {
                    // Use a toast to inform that an error has ocurred to the user.
                    Materialize.toast(ERROR_MSG, TOAST_LIFESPAN_MILLI);
                    console.log("Response object: " + xhr);
                    console.log("Error message: " + error);
                    console.log("Exception: " + exThrown);
                }
            })
        } else {
            // User hasn't selected an acceptable number of molecules.
            // Check how many molecules were selected and feedback the user accordingly.
            if (selectedMolecules.size() < MIN_MOLECULE_COUNT) {
                Materialize.toast(SELECT_MOLECULE_MSG, TOAST_LIFESPAN_MILLI);
            } else if (selectedMolecules.size() > MAX_MOLECULE_COUNT) {
                Materialize.toast(MAX_MOLECULE_REACHED_MSG, TOAST_LIFESPAN_MILLI);
            }
        }
    });

    // Delete button click function
    $("#deleteMoleculeButton").click(function() {
        if (!($(this).hasClass('disabled'))) {
            // Capture each selected molecule item and run the following code using each one of them inside the "this" variable.
            $(".molecule-list-box li.active").each(function(){
                // Setup all the necessary content in a JSON to be sent to the server.
                var deleteData = {};
                deleteData.id = $(this).data("moleculeId");
                deleteData.ownerId = $(this).data("ownerId");
                deleteData._method = "DELETE";

                $.ajax({
                    type:"DELETE",
                    // Call the especific delete URL, which basically overrides the necessity of sending any extra data to the server.
                    url: DELETE_URL + "/" + deleteData.id,
                    // We send it anyway in case of server-side version changes.
                    data: deleteData,
                    success: function(response) {
                        // Alert the user that the molecule has been successfully removed.
                        Materialize.toast(REMOVE_SUCCESS_MSG);
                        // Refresh the page to show the updated molecule list.
                        window.location.reload(true);
                    },
                    error: function(xhr, error, exThrown) {
                        // Use a toast to inform that an error has ocurred to the user.
                        Materialize.toast(ERROR_MSG);
                        console.log("Response object: " + xhr);
                        console.log("Error message: " + error);
                        console.log("Exception: " + exThrown);
                    }
                });
            });
        }
    });
});



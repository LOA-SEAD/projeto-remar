$(document).ready(function () {
    Materialize.updateTextFields();
    $('.tooltipped').tooltip({delay: 50});

    $('.admin-toggle a').click(function (e) {
        e.stopPropagation();

        var userId = $(this).closest('li').data('user-id');
        // toggle admin status
        $.ajax ({
            method: 'GET',
            data: {userid: userId},
            url: '/group/toggleUserAdminStatus'
        });

        // and toggle 'active' class based on the status
        $(this).toggleClass('active');

        var $icon = $(this).children('i').first();
        $icon.tooltip('remove');

        if ($(this).hasClass('active')) {
            $icon
                .attr('data-tooltip', 'Remover Administrador')
                .tooltip();
        } else {
            $icon
                .attr('data-tooltip', 'Tornar Administrador')
                .tooltip();
        }
    });

    $('.sortable')
     .on('click', 'li', function(e) {
         // stops row from turning into 'active' state if clicked on the admin-toggle button
         if (e.target.classList.contains('click-hungry')) {
             e.target.click();
             return;
         }

         $(this).toggleClass('selected');
     })
     .sortable({
         connectWith: '.sortable',
         delay: 150, // needed to prevent accidental drag when trying to select
         revert: 0,
         helper: function (e, item) {
             // Grabbing an unhighlighted item to drag deselects everything else
             if (!item.hasClass('selected')) {
                 item.addClass('selected').siblings().removeClass('selected');
             }

             // Passing the selected items to the 'stop()' function

             // Clone the selected items into an array
             var elements = item.parent().children('.selected').clone();

             // Add a property to 'item' called 'multidrag' that contains the
             //     selected items, then remove the selected items from the source list
             item.data('multidrag', elements).siblings('.selected').remove();
             // Now the selected items exist in memory, attached to the 'item',
             //     so we can access them later when we get to the 'stop()' callback

             // Create the helper
             var helper = $('<div/>');
             return helper.append(elements);
         },
         start: function (e, ui) {
             // Resize placeholder to the size of the objects being dragged
             var height = ui.item.outerHeight();
             var length = ui.item.data('multidrag').length;
             ui.placeholder.outerHeight((height - 0.5) * length);
         },
         stop: function (e, ui) {
             // Now we access those items that we stored in items data
             var $elements = ui.item.data('multidrag');

             // 'elements' now contains the originally selected items from the source list

             // Finally, insert the selected items after the 'item', then remove the 'item'
             //      since item is a duplicate of one of the selected items
             ui.item.after($elements).remove();

             // Remove 'selected' class
             $elements.removeClass('selected', 1000);
         },
         receive: function (e, ui) {
             var $elements = ui.item.data('multidrag');

             // Store all the selected users ids in an array
             var users = [];
             $elements.each(function() {
                 users.push($(this).data('user-id'));
             });

             // Specific behaviour for each of the sortable lists
             var sender = $(ui.sender).attr('id');
             var receiver = $(this).attr('id');
             if (receiver == 'members' && sender == 'available-users') {
                 // if the users were dragged from available users to members list, add those users to the group
                 // call an ajax function to add those users to the group
                 $.ajax ({
                     method: 'POST',
                     data: { users: JSON.stringify(users) },
                     url: '/group/addUsers',
                     success: function(e) { Materialize.toast(GMS.USER_ADDED_TO_GROUP_MESSAGE)}
                 });

                 var $toggle = $('#admin-toggle-button-model');

                 $elements.each(function () {
                     // for each element, give it a copy of the admin status toggle
                     $toggle
                         .clone(true, true)
                         .removeAttr('id')
                         .appendTo($(this));
                     // and then resize the whole row
                     $(this)
                         .children('div:nth-child(2)')
                             .removeClass('s12 m10')
                             .addClass('s6 m7');

                     console.log($(this));
                     console.log($(this).find('.admin-toggle a i'));
                     console.log($(this).find('.admin-toggle a i').first());

                     $(this)
                         .find('.admin-toggle a i').first()
                             .attr('data-tooltip', 'Tornar Administrador')
                             .tooltip({
                                 tooltip: 'Tornar Administrador',
                                 position: 'bottom',
                                 delay: 50
                             });
                 });
             } else if (receiver == 'available-users' && sender == 'members') {
                 // else if the users were dragged from members list to available users, remove them from the group
                 // call an ajax function to remove those users from group
                 $.ajax ({
                     method: 'POST',
                     data: { users: JSON.stringify(users) },
                     url: '/group/removeUsers'
                 });

                 // remove admin toggle button and resize whole row
                 $elements.each(function() {
                     $(this).children('.admin-toggle').remove();
                     $(this).children('div:nth-child(2)')
                         .removeClass('s6 m7')
                         .addClass('s12 m10');
                 });
             }
         }
     });
});

/**
 * Created by garciaph on 07/12/17.
 *
 * This plugin sorts a <table>'s based either on:
 *      -> origin == 'html': any of it's <tbody>'s <td>'s content, which in jQuery it's translated as the $el.html()
 *      -> origin == 'data': any of it's <tbody>'s <td>'s data fields. The field itself must be specified in the 'dataLabel' parameter
 *          so, it the origin is 'data' and the dataLabel is 'id', then the table will be
 *          sorted based on the data-id attribute, as in <td data-id='#'>.
 *
 * This plugin has 2 modes, 'increasing' and 'decreasing', which are quite self-explanatory.
 *      -> 'increasing' means that the table will be sorted from the smallest to the highest
 *          i.e. [1, 2, 3, 4, 5]
 *      -> 'decreasing' means that the table will be sorted from the highest to the smallest.
 *          i.e. [5, 4, 3, 2, 1]
 */



$.fn.tableSort = function(opts) {
    var $tableBody = this.children('tbody'),
        defaults = {
            keySelector: 'td.defaultSelector',
            mode : 'increasing',
            origin: 'html',
            dataLabel: ''
        },
        settings = $.extend(defaults, opts),
        rows = $tableBody.find('tr').get();

    rows.sort(function (a, b) {
        var keyA, keyB;

        if (settings.origin == 'html') {
            keyA = $(a).children(settings.keySelector).html();
            keyB = $(b).children(settings.keySelector).html();
        } else if (settings.origin == 'data') {
            keyA = $(a).children(settings.keySelector).data(settings.dataLabel);
            keyB = $(b).children(settings.keySelector).data(settings.dataLabel);
        }

        /*
         Expected Returns:
         0   =  exact match
         -1  =  keyA < keyB
         1   =  keyA > keyB
         */

        switch (typeof keyA) {
            case 'boolean':
                // In this case, we are considering TRUE to be higher than FALSE, since TRUE == 1 and FALSE == 0
                if (keyA == keyB) return 0;         // keyA(true) == keyB(true) || keyA(false) == keyB(false)
                else if (keyA && !keyB) return 1;   // keyA(true) > keyB(false)
                else return -1;                     // keyA(false) < keyB(true)
            case 'number':
                if (keyA == keyB) return 0;
                else if (keyA < keyB) return -1;
                else return 1;
            case 'string':
                return keyA.localeCompare(keyB);
            default:
                console.log('ERROR @ tableSort: Cannot sort objects of type ' + typeof keyA);
                return 0;
        }
    });

    // If 'decreasing' mode is set, reverse the table
    if (settings.mode == 'decreasing') {
        rows == rows.reverse();
    }

    // Append those rows to the original table
    $.each(rows, function (index, row) {
        $tableBody.append(row);
    });
};
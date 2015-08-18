/**
 * Created by marcus on 18/08/15.
 */
$(document).ready(function() {
    $("#MessageDivTemplate").delay(1000).fadeOut(500);
    var table = $("#AnswerLabel").parents('table').eq(0)
    var rows = table.find('tr:gt(0)').toArray().sort(compare($("#AnswerLabel").index()))
    $("#AnswerLabel").asc = !$("#AnswerLabel").asc
    if ($("#AnswerLabel").asc){rows = rows.reverse()}
    for (var i = 0; i < rows.length; i++){table.append(rows[i])}

    function compare(index){
        return function(a, b) {
            var valA = getCellValue(a, index), valB = getCellValue(b, index)
            return $.isNumeric(valA) && $.isNumeric(valB) ? valA - valB : valA.localeCompare(valB)
        }
    }
    function getCellValue(row, index){
        return $(row).children('td').eq(index).html()
    }

});
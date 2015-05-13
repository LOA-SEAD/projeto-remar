define(function()
{
    var levels = [];

    function GetSize(level) {
        return levels[level].size;
    }
    function GetTime(level) {
        return levels[level].time;
    }
    function GetData(level) {
        return levels[level].data;
    }
    function GetNumberOfLevels() {
        return levels.length - 1;
    }

    function raiz(valor, b)
    {

        if (!hasMathMLSupport()) {
            return !b || b === 2
                    ? '&radic;<span style="text-decoration:overline,">&nbsp;' + valor + '&nbsp;</span>'
                    : '<sup>' + b + '</sup>&radic;<span style="text-decoration:overline,">&nbsp;' + valor + '&nbsp;</span>';
        } else {
            return !b || b === 2
                    ? '<msqrt> <mi>' + valor + '</mi> </msqrt>'
                    : '<mroot><mrow><mi>' + valor + '</mi></mrow><mn>' + b + '</mn></mroot>';
        }
    }

    function elev(a, b)
    {
        if (!hasMathMLSupport()) {
            return a + '<sup>' + b + '</sup>';
        }
        else {
            return '<msup> <mi>' + a + '</mi> <mn>' + b + '</mn> </msup>';
        }
    }
    ;

    function AddLevel(size, time, data)
    {
        levels.push({
            size: size,
            time: time,
            data: data
        });

        return levels[levels.length - 1];
    }

    readJSON();

    function readJSON() {
        $.ajax({
            url: "MathJong/json/fases.json",
            //force to handle it as text
            dataType: "text",
            mimeType: "application/json",
            success: function(data) {

                //data downloaded so we call parseJSON function 
                //and pass downloaded data
                var fases = $.parseJSON(data);
                //now json variable contains data in json format
                //let's display a few items

                for (i = 0; i < fases.length; i++) {

                    for (j = 0; j < fases[i].linha; j++)
                        for (k = 0; k < fases[i].coluna; k++) {
                            var str = "";
                            var index = 0;
                            while (index < fases[i].data[j][k].length) {
                                if (fases[i].data[j][k][index] === '!') {
                                    index = index + 5;
                                    var param1 = "";
                                    while (fases[i].data[j][k][index] !== ')'
                                            && fases[i].data[j][k][index] !== ',') {
                                        param1 += fases[i].data[j][k][index++];
                                    }
                                    var param2 = "";
                                    if (fases[i].data[j][k][index] === ')') {
                                        param2 = 2;
                                    } else {
                                        index++;
                                        while (fases[i].data[j][k][index] !== ')') {
                                            param2 += fases[i].data[j][k][index++];
                                        }
                                    }
                                    str += raiz(param1, param2);
                                    index++;
                                } else if (fases[i].data[j][k][index] === '@') {
                                    index = index + 5;
                                    var param1 = "";
                                    while (fases[i].data[j][k][index] !== ')'
                                            && fases[i].data[j][k][index] !== ',') {
                                        param1 += fases[i].data[j][k][index++];
                                    }
                                    var param2 = "";
                                    if (fases[i].data[j][k][index] === ')') {
                                        param2 = 2;
                                    } else {
                                        index++;
                                        while (fases[i].data[j][k][index] !== ')') {
                                            param2 += fases[i].data[j][k][index++];
                                        }
                                    }
                                    str += elev(param1, param2);
                                    index++;
                                } else {
                                    str += fases[i].data[j][k][index++];
                                }

                            }

                            fases[i].data[j][k] = str;
                        }

                    AddLevel([fases[i].linha, fases[i].coluna], fases[i].time, fases[i].data);
                }
            }
        });
    }

    function hasMathMLSupport() {

        var div = document.getElementById("#myDiv");
        div = document.createElement("div");
        div.id = "#myDiv";
        div.innerHTML = "<math><mspace height='23px' width='77px'/></math>";
        document.body.appendChild(div);
        var box = div.firstChild.firstChild.getBoundingClientRect();
        var mathMLSupport = Math.abs(box.height - 23) <= 1 && Math.abs(box.width - 77) <= 1;
        if (mathMLSupport)
            hasMathMLSupport = function() {
                return true;
            };
        else
            hasMathMLSupport = function() {
                return false;
            };
        $("#myDiv").remove();
        return mathMLSupport;
    }



    /* AddLevel(
     [3, 4],
     180,
     [
     ["5+7",  "-6+18",  "4+8",     "12"],
     ["7+8",     "15", "10+5", "-10+25"],
     ["7+4", "10+7-6",   "11",  "21-10"]
     ]
     );
     
     AddLevel(
     [4, 4],
     240,
     [
     [    "7*3",  "42/2",  "-8+29",   "21"],
     [    "75/3",    "25",    "5*5", "17+8"],
     [    "22-5", "34/2",     "17", "25-8"],
     [  "40-12", "14+14", "56/2",   "7*4"]
     ]
     );
     
     AddLevel(
     [5, 4],
     300,
     [
     [ "1+1",   "5-3", "2*1", "8/4"],
     [ "3+2", "2*3-1", "25/5", elev(5,1)],
     [ "5+2",   "49/7",  "10-3",   raiz(49)],
     [ raiz(100), "15-5",   "2*5",   "40/4"],
     ["39/3",   "7+6", "2*6+1",  "20-7"]
     ]
     );
     
     AddLevel(
     [6, 4],
     480,
     [
     [elev(2,2), "1+3", "2*2", raiz(16)],
     ["3*2", "12/2", raiz(36), elev(2,2)+"+ 2"], 
     ["7*2", "20-6", "28/2", "15-1"],
     ["5*4", raiz(400), "5*5-5", ""+elev(4,2)+"+"+elev(2,2)],
     ["8*2", elev(2,4), "3*5+1", "32/2"],
     ["5*5+2", elev(4,2)+"+11", "4*5+7", "54/2"]
     ]
     );
     
     AddLevel(
     [5, 6],
     720,
     [
     [elev(3,1), "15/5", "22 - 19", raiz(27,3), raiz(9), "1 * 3"],
     [elev(3,2), "2*3+3", "3*3", "5+4", raiz(81), "27/3"],
     ["10+9", "9*2+1", "50-31", "5*3+"+elev(2,2), elev(3,2)+"+2*5", 
     elev(5,2)+"-2*3"],
     ["11*2", raiz(484), elev(5,2)+"-"+elev(3,1), elev(4,2)+"+6", 
     "88/4", "32-2*5"],
     ["48/2", raiz(576), "12*2", "72/3", "6 * "+elev(2,2), 
     elev(5,2)+"-"+elev(5,0)]
     ]
     );
     
     AddLevel(
     [6, 6],
     1080,
     [
     [raiz(16), elev(2,1) + " + 2", raiz(64,3), elev(2,2), 
     elev(2,1)+"+"+elev(2,1), "2*2"],
     [raiz(100), elev(3,2) + " + 1", "2*5", elev(2,2) + " + 6", elev(10,1),
     "30/3"],
     [raiz(225), "5*3", elev(2,4) + " - 1", elev(2,3) + " + 7", 
     elev(4,2)+"-"+elev(4,0), "90/6"],
     [raiz(625), elev(5,2), "5*5", elev(4,2) + "+" + elev(3,2), 
     "75/3", "12+13"],
     ["13*2", raiz(676), elev(5,2)+"+"+elev(5,0), elev(6,2)+" - 10", 
     "52/2", "30-4"],
     [raiz(900), elev(5,2)+"+"+elev(5,1), elev(2,5)+" - 2", "90/3", 
     "5*6", elev(4,2)+" + 14"]
     ]
     ); */

    // To add new levels, make a call for the @method AddLevel(size, time, data).
    // The example below illustrates this:
    // AddLevel(
    //     [2, 3],
    //     900,
    //     [
    //         [ "10", "5 + 5" ],
    //         [ "20", "2 * 10" ]
    //     ]
    // )

    return {
        AddLevel: AddLevel,
        obterTexto: GetData,
        obterTempo: GetTime,
        obterTamanhoDoNivel: GetSize,
        obterNumeroDeNiveis: GetNumberOfLevels
    };
});

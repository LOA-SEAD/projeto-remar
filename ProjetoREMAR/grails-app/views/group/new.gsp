<%--
  Created by IntelliJ IDEA.
  User: deniscapp
  Date: 5/18/16
  Time: 12:21 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="materialize-layout">
</head>

<body>
<div class="cluster-header">
    <p class="text-teal text-darken-3 left-align margin-bottom">
        <i class="small material-icons left">group_add</i>Criar novo grupo
    </p>
    <div class="divider"></div>
</div>
    <div class="row">
        <div style="bottom: -1em;"  class="card white col l8 s10 offset-l2 offset-s1">
            <div class="card-content">
                    <div class="row">
                        <div class="input-field col l6 offset-l3">
                            <input name="groupname" id="group-name" onkeyup="findGroup()" type="text" class="validate" required>
                            <label for="group-name">Nome do Grupo</label>
                        </div>
                    </div>
                    <div id="submit-button" class="row">
                        <div>

                            <a class="btn waves-effect waves-light remar-orange" type="submit" name="action">
                                Criar
                            </a>

                        </div>
                    </div>
            </div>
        </div>
    </div>
<script>
    function findGroup(){
        if($('#group-name').val() == ""){
            $("#submit-button").empty();
            $("#submit-button").append(" <div>" +
                    "                            <a class=\"btn waves-effect waves-light remar-orange disabled\" name=\"action\">Criar " +
                    "</a> " +
                    "</div>");
        }
        else{
            $.ajax({
                type: "GET",
                url: "/group/findGroup",
                data: {
                    name: $('#group-name').val() },
                success: function(data){
                    console.log(data);
                    if(data != "null"){
                        $("#submit-button").empty();
                        $("#submit-button").append(" <div>" +
                                "                            <a class=\"btn waves-effect waves-light remar-orange disabled\" name=\"action\">Criar " +
                                "</a> " +
                                "</div>");
                    }
                    else{
                        $("#submit-button").empty();
                        $("#submit-button").append(" <div>" +
                                "                            <a class=\"btn waves-effect waves-light remar-orange\" onclick='createNewGroup()' type=\"submit\" name=\"action\">Criar " +
                                "</a> " +
                                "</div>");

                    }
                }
            })

        }
    }

    function createNewGroup(){
        $.ajax({
            type: "POST",
            url: "/group/create",
            data: {
                groupname: $('#group-name').val() },
            success: function(data){
                console.log(data);
                window.location = location.origin + "/group/show/" + data;
                }
        })
    }

</script>
</body>
</html>
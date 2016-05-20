<%--
  Created by IntelliJ IDEA.
  User: deniscapp
  Date: 5/18/16
  Time: 5:24 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="materialize-layout">
</head>

<body>
<div class="cluster-header">
    <p class="text-teal text-darken-3 center-align margin-bottom">
      ${group.name}
    </p>
    <div class="divider"></div>
    <div class="center-align">
        <p align="center" style="font-size: 0.6em;">Dono(s):
            <g:each var="owner" in="${group.owners}">
                %{--<g:if test="${owner.id == session.user.id}">--}%
                    %{--Você--}%
                %{--</g:if>--}%
                ${owner.firstName +' '+ owner.lastName}
            </g:each>
        </p>
    </div>
</div>
<div class="row">
    <div class="col l10">
        <g:form controller="group" action="addUser">
            <div class="input-field col l6">
                <input placeholder="Procure pelo usuário para adicioná-lo" name="term" id="search-user" type="text">
                <label for="search-user"><i class="fa fa-search"></i></label>
                <input type="hidden" value="${group.id}" name="groupid">
                <input type="hidden" value="" id="user-id" name="userid">
            </div>
            <div class="col 10">
                <button class="btn waves-effect waves-light" type="submit" name="action">Adicionar
                    <i class="material-icons right">group_add</i>
                </button>
            </div>
        </g:form>

    </div>
</div>
<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>

<script>

    $("#search-user").autocomplete({
        source: function(request,response){
            $.ajax({
                type:'GET',
                url:"/user/autocomplete",
                data: {
                    query: request.term
                },
                success: function(data) {
                    console.log(data);
                    let id = (Object.keys(data));
                    $("#user-id").prop("value",id);
                    response(data);
                }
            })
        },
        select: function(event, ui) {
            console.log(ui.item.label);
        },
        messages: {
            noResults: '',
            results: function() {}
        },
        minLength: 3
    });

</script>

</body>
</html>
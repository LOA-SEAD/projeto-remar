<%--
  Created by IntelliJ IDEA.
  User: deniscapp
  Date: 5/18/16
  Time: 5:24 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
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
    <div class="row">
        <div class="col l10">
            <div class="input-field col l6">
                <input placeholder="Procure pelo usuário para adicioná-lo" name="searchuser" id="search-user" type="text">
                <label for="search-user"><i class="fa fa-search"></i></label>
            </div>
        </div>
    </div>
</div>
</body>
</html>
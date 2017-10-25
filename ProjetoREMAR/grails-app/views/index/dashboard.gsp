<%--
  Created by IntelliJ IDEA.
  User: loa
  Date: 25/06/15
  Time: 11:04
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>

<html>
    <head>
        <meta name="layout" content="materialize-layout">
    </head>
    <body>
        <div class="row cluster">
            <div class="cluster-header">
                <h4>Confira os modelos disponíveis para customização!</h4>

                <div class="divider"></div>
            </div>
            <div class="row show">
                <div class="row">
                    <g:render template="/resource/gameModelCard" model="${resourceInstanceList}"/>
                </div>
            </div>
        </div>

        <div id="userDetailsModal" class="modal" style="width:40%">
            %{-- Preenchido pelo Javascript --}%
        </div>

        <g:javascript src="remar/user/showProfile.js"/>
        <g:javascript src="remar/layouts/dashboard.js"/>
    </body>
</html>

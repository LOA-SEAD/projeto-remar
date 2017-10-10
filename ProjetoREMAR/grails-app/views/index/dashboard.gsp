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
            <div class="row show">
                <div class="subtitle">
                    <p class="text-teal text-darken-3 left-align margin-bottom">
                         <h5>
                            Confira os modelos disponíveis para customização!
                         </h5>
                    </p>
                </div>
                <div class="row">
                    <div class="center">
                        <g:render template="/resource/custCards" model="${resourceInstanceList}"/>
                    </div>
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

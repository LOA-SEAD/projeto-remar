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
        <p class="left-align margin-bottom" style="font-size: 24px;">
            <i class="left small material-icons">work</i>Gerenciar R.E.As
        </p>
        <div class="divider"></div>
        <br />
        <div class="card-list two-cards">
            <div class="row show developer">
                <g:if test="${resourceInstanceList}">
                    <g:render template="cads" model="[resourceInstanceList:resourceInstanceList]" />
                </g:if>
                <g:else>
                    <p>Não há recursos cadastrados, ainda. Envie um novo!  :)</p>
                </g:else>
                <div class="fixed-action-btn my-position">
                    <a class="btn-floating btn-large my-orange" href="/resource/create">
                        <i class="material-icons large">add</i>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'game-index.js')}"></script>
</body>
</html>

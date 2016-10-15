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
                <g:form action="create" controller="group" method="post">
                    <div class="row">
                        <div class="input-field col l6 offset-l3">
                            <input name="groupname" id="group-name" type="text" class="validate" required>
                            <label for="group-name">Nome do Grupo</label>
                        </div>
                    </div>

                    <div class="row">
                        <div>
                            <button class="btn waves-effect waves-light" type="submit" name="action">Criar
                                <i class="material-icons right">send</i>
                            </button>
                        </div>
                    </div>
                </g:form>

            </div>

        </div>
    </div>
</body>
</html>

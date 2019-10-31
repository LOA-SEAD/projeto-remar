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
    <div class="row cluster">

        <div class="row cluster-header">
            <h4><g:message code='group.label.newGroup' default="Criar novo grupo"/></h4>
            <div class="divider"></div>
        </div>

        <div class="row show">
            %{-- Erros no preenchimento do formulário --}%
            <g:if test="${request?.message == 'blank_name'}">
                <div class="error-box">
                    <i class="material-icons tiny">error</i>
                    <g:message code='group.label.noName'/>
                </div>
            </g:if>
            <g:elseif test="${request?.message == 'name_already_exists'}">
                <div class="error-box">
                    <i class="material-icons tiny">error</i>
                    <g:message code='group.label.sameName'/>
                </div>
            </g:elseif>

            <div class="row">
                <div class="card white col l8 s10 offset-l2 offset-s1">
                    <div class="card-content">
                        <div class="row">
                            <div class="row no-margin">
                                <form action="/group/create" name="group-create-form" class="col s12">
                                    <div class="row">
                                        <div class="input-field col s12">
                                            <input id="group-name" name="groupname" type="text">
                                            <label for="group-name">
                                                <g:message code='group.label.groupName'/>
                                            </label>
                                        </div>
                                    </div>

                                    <div class="row no-margin">
                                        <div class="input-field col s12 center-align">
                                            <input type="submit" class="waves-effect waves-light btn" value="Criar">
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
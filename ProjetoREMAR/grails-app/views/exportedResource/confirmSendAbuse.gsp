<%--
Created by IntelliJ IDEA.
User: loa
Date: 10/06/15
Time: 09:55
--%>

<%@ page import="br.ufscar.sead.loa.remar.GroupExportedResources" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="materialize-layout">
    <title></title>
</head>
<body>

<div class="row cluster">
    <div class="cluster-header">
        <p class="text-teal text-darken-3 left-align margin-bottom">
            <i class="small material-icons left">block</i><g:message code="exportedResource.label.reportAbuse" default="Reportar Abuso"/>
        </p>
        <div class="divider"></div>
    </div>
    <div class="row show">
        <div class="row">

            <ul class="collapsible popout" data-collapsible="expandable">
                <li>
                    <div class="collapsible-header active">
                        <i class="material-icons">feedback</i><g:message code="exportedResource.label.confirmMessage" default="Confirmação de mensagem"/>
                    </div>
                    <div id="info" class="collapsible-body">
                        <div class="row">
                            <h5><g:message code="exportedResource.label.sentMessageSuccess" default="Sua mensagem foi enviada com sucesso!"/></h5>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>
</div>


</body>
</html>

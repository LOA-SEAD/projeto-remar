
<%@ page import="projetoremar.Palavras" %>
<!DOCTYPE html>
<html>
	<head>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
        <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
        <script src="${resource(dir:"js",file:"editableTable.js")}" type="text/javascript"> </script>
        <script src="${resource(dir:"js" ,file:"scriptTable.js")}" type="text/javascript"> </script>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'palavras.label', default: 'Palavras')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
        <style>
        .ui-dialog .ui-state-error { padding: .3em; }
        .validateTips { border: 1px solid transparent; padding: 0.3em; }
        .ui-dialog .ui-state-error { padding: .3em; }
        </style>
        <script type="text/javascript">
            $(function() {
                var dialog, form = document.forms[0],
                        questao = $("#questao"),
                        resposta = $("#resposta"),
                        contribuicao = $("#contribuicao")
                        allFields = $([]).add(questao).add(resposta).add(contribuicao);


                function addQuestion() {
                    var id =
                    jQuery.ajax({
                        url: "/ProjetoREMAR/palavras/update/" + id,
                        type: "POST",
                        data: {resposta: resposta.val(), dica: questao.val(), contribuicao: contribuicao.val(),'_method': 'PUT'}

                    });

                    dialog.dialog( "close" );
                    //console.log(questao.val());

                    // console.log(contribuicao.val());

                }
                dialog = $( "#dialog-form" ).dialog({

                    autoOpen: false,
                    height: 300,
                    width: 500,
                    modal: true,
                    buttons: {
                        "Salvar Questão": addQuestion,
                        Cancel: function() {
                            dialog.dialog( "close" );
                        }
                    },
                    close: function() {

                        allFields.removeClass( "ui-state-error" );
                    }
                });

                form = dialog.find( "form" ).on( "button", function( event ) {
                    event.preventDefault();
                    addQuestion();
                });

                $( "#edit-question" ).button().on( "click", function() {
                    dialog.dialog( "open" );
                });
            });

        </script>
	</head>
	<body>
		<a href="#list-palavras" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-palavras" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table id="table">
			<thead>
					<tr>
					
						<g:sortableColumn property="resposta" title="${message(code: 'palavras.resposta.label', default: 'Resposta')}" />
					
						<g:sortableColumn property="dica" title="${message(code: 'palavras.dica.label', default: 'Dica')}" />
					
						<g:sortableColumn property="contribuicao" title="${message(code: 'palavras.contribuicao.label', default: 'Contribuicao')}" />

                        <g:sortableColumn property="Editar" title="Editar" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${palavrasInstanceList}" status="i" var="palavrasInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td data-id="${fieldValue(bean: palavrasInstance, field: "id")}"><g:link action="show" id="${palavrasInstance.id}">${fieldValue(bean: palavrasInstance, field: "resposta")}</g:link></td>
					
						<td>${fieldValue(bean: palavrasInstance, field: "dica")}</td>
					
						<td>${fieldValue(bean: palavrasInstance, field: "contribuicao")}</td>

                        <td>
                            <div id="editDiv">
                            <fieldset class="buttons">
                                <g:submitButton  type="button" class="edit" id="edit-question" name="Editar Questão"/>
                            </fieldset>
                            </div>
                        </td>

					</tr>
				</g:each>
				</tbody>
			</table>
            <div id="dialog-form" title="Editar Questão" >
                <fieldset>
                    <label for="questao">Questão</label>

                    <input type="text" name="questao" id="questao" value="${questao}" class="text ui-widget-content ui-corner-all"/>

                    <label for="resposta">Resposta</label>
                    <input type="text" name="resposta" value="${resposta}"  id="resposta" class="text ui-widget-content ui-corner-all"/>
                    <label for="contribuicao">Contribuição</label>
                    <input type="text" name="contribuicao" id="contribuicao" value="${contribuicao}" class="text ui-widget-content ui-corner-all"/>

                    <!-- Allow form submission with keyboard without duplicating the dialog button -->
                    <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
                </fieldset>
            </div>

			<div class="pagination">
				<g:paginate total="${palavrasInstanceCount ?: 0}" />
                <g:link action="newJson" controller="palavras" >Finalizar </g:link>
            </div>
		</div>
	</body>
</html>

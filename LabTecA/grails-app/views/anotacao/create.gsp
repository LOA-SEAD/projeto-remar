<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'anotacao.label', default: 'Anotacao')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<g:external dir="css" file="anotacao.css"/>
		<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
		<g:javascript src="anotacao.js" />

		<g:javascript src="iframeResizer.contentWindow.min.js"/>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
		<link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

	</head>




	<body>
	<div class="cluster-header">
		<p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
			<i class="small material-icons left">grid_on</i>Criação de Anotação
		</p>
	</div>


		<div id="create-anotacao" class="content scaffold-create" role="main">

			<g:form url="[resource:anotacaoInstance, action:'save']" >
                <form class="col s12">
                    <fieldset class="form"  style="border:none"  >
                        <div class="row">
                            <div class="input-field col s12">
                                <span id="anot">Insira o passo a passo* </span>
                            </div>
                            <div class="row">
                                <div class="input-field col s12">
                                    <!-- g:textField name="informacao" required="" value="${anotacaoInstance?.informacao}"/>-->
                                    <g:textArea name="informacao" required="" value="${anotacaoInstance?.informacao}"/>
                                </div>
                            </div>
                        </div>
                    </fieldset>

                    <fieldset class="buttons" style="border:none">
                        <div class="buttons col s1 m1 l1 offset-s8 offset-m10 offset-l10" style="margin-top:0px">
                            <button class="btn waves-effect waves-light my-orange" type="submit" name="save" class="save" id="submitButton">
                                Enviar
                            </button>
                        </div>
                    </fieldset>
                </form>

            </g:form>
		</div>
	</body>
</html>



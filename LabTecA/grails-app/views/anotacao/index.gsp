
<%@ page import="br.ufscar.sead.loa.labteca.remar.Anotacao" %>
<!DOCTYPE html>
<html>
	<head>
		<g:external dir="css" file="anotacao.css"/>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'anotacao.label', default: 'Anotacao')}" />
		<title>LabTeca</title>
		<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
		<g:javascript src="anotacao.js" />

		<g:javascript src="iframeResizer.contentWindow.min.js"/>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
		<link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	</head>
	<body>
		<div class="cluster-header">
			<p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
				<i class="small material-icons left">grid_on</i>Customização - Anotação
			</p>
		</div>


            <div class="row">
                <div style=" margin-bottom: 10px; color:#333333">
                    Aqui você pode gerar, alterar e deletar anotações.
                </div>

                <div id="chooseAnotacao" class="col s12 m12 l12">
                    <br>
                    <div class="row">
                         <div class="col s6 m3 l3 offset-s6 offset-m9 offset-l9">
                             <input  type="text" id="SearchLabel" placeholder="Buscar"/>
                         </div>
                     </div>


                    <div class="row">
                        <div class="col s12 m12 l12">
                            <table class="highlight" id="table" style="margin-top: -30px;">
                                <thead>
                                <tr>
                                    <th>Selecionar
                                        <div class="row" style="margin-bottom: -10px;">
                                            <button style="margin-left: 3px; background-color: #795548" class="btn-floating " id="BtnCheckAll" onclick="check_all()"><i  class="material-icons">check_box_outline_blank</i></button>
                                            <button style="margin-left: 3px; background-color: #795548" class="btn-floating " id="BtnUnCheckAll" onclick="uncheck_all()"><i  class="material-icons">done</i></button>
                                        </div>
                                    </th>
                                    <th id="titleLabel">Anotação <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
                                    <th>Ações <div class="row" style="margin-bottom: -10px;"><button  class="btn-floating" style="visibility: hidden"></button></div></th>
                                </tr>
                                </thead>

                                <tbody>
                                <g:each in="${anotacaoAnotacaoInstanceList}" status="i" var="anotacaoAnotacaoInstance">
                                    <tr id="tr${anotacaoAnotacaoInstance.id}" class="selectable_tr" style="cursor: pointer;"
                                        data-id="${fieldValue(bean: anotacaoAnotacaoInstance, field: "id")}" data-owner-id="${fieldValue(bean: anotacaoAnotacaoInstance, field: "ownerId")}"
                                        data-checked="false">
                                        <td class="_not_editable">
                                            <input style="background-color: #727272" id="checkbox-${anotacaoAnotacaoInstance.id}" class="filled-in" type="checkbox">
                                            <label for="checkbox-${anotacaoAnotacaoInstance.id}"></label>
                                        </td>
                                        <td>${fieldValue(bean: anotacaoAnotacaoInstance, field: "anotacao")}</td>
                                       <!-- <td>${anotacaoAnotacaoInstance.answers[anotacaoAnotacaoInstance.correctAnswer]}</td> -->
                                        <td> <i style="color: #7d8fff !important; margin-right:10px;" class="fa fa-pencil " onclick="_modal_edit($(this.closest('tr')))" ></i>
                                        </td>
                                    </tr>
                                </g:each>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col s1 m1 l1 offset-s4 offset-m8 offset-l8">
                            <a data-target="createModal" name="create" class="btn-floating btn-large waves-effect waves-light modal-trigger my-orange tooltipped" data-tooltip="Criar anotacao"><i class="material-icons">add</i></a>
                        </div>
                        <div class="col s1 offset-s1 m1 l1">
                            <a name="delete" class="btn-floating btn-large waves-effect waves-light my-orange tooltipped" data-tooltip="Exluir anotação" ><i class="material-icons" onclick="_open_modal_delete()">delete</i></a>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col s2">
                            <button class="btn waves-effect waves-light my-orange"  name="save" id="submitButton" onclick="_submit()">Enviar
                                <i class="material-icons">send</i>
                            </button>
                        </div>
                    </div>



                    <div id="editModal" class="modal">
                        <div class="modal-content">
                            <h4>Editar Anotacao</h4>
                            <div class="row">
                                <g:form method="post" action="update" resource="${AnotacaoInstance}">
                                    <div class="row">
                                        <div class="input-field col s12">
                                            <label id="labelTitle" class="active" for="editTitle">Anotação</label>
                                            <input id="editTitle" name="title" required=""  type="text" class="validate" length="95" maxlength="95">
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="input-field col s9">
                                            <label id="labelAnotacao" class="active" for="editAnotacao0">Alternativa 1</label>
                                            <input type="text" class="validate" id="editAnotacao0" name="anotacao1" required="" maxlength="15" length="15"/>
                                        </div>
                                        <div class="col s2">
                                            <input type="radio" id="editRadio0" name="correctAnswer" value="0" checked="checked"/>
                                            <label for="editRadio0">Alternativa correta</label>
                                        </div>
                                    </div>

                                    <input type="hidden" id="AnotacaoID" name="AnotacaoID">
                                    <div class="col l10">
                                        <g:submitButton name="update" class="btn btn-success btn-lg my-orange" value="Salvar" />
                                    </div>
                                </g:form>
                            </div>
                        </div>
                    </div>


                    <div id="createModal" class="modal">
                        <div class="modal-content">
                            <h4>Criar Anotação</h4>
                            <div class="row">
                                <g:form action="save" resource="${AnotacaoInstance}">
                                    <div class="row">
                                        <div class="input-field col s12">
                                            <label id="labelTitleCreate" class="active" for="editTitleCreate">Anotacao</label>
                                            <input id="editTitleCreate" name="title" required=""  type="text" class="validate" length="95" maxlength="95">
                                        </div>
                                    </div>
                                    <div class="col l10">
                                        <g:submitButton name="create" class="btn btn-success btn-lg my-orange" value="Criar" />
                                    </div>
                                </g:form>
                            </div>
                        </div>
                    </div>


                    <div id="deleteModal" class="modal">
                        <div class="modal-content">
                            <div id="delete-one-anotacao">
                                Você tem certeza que deseja excluir essa anotação?
                            </div>
                            <div id="delete-several-anotacao">
                                Você tem certeza que deseja excluir essas anotações?
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn waves-effect waves-light modal-close my-orange" onclick="_delete()" style="margin-right: 10px;">Sim</button>
                            <button class="btn waves-effect waves-light modal-close my-orange" style="margin-right: 10px;">Não</button>
                        </div>
                    </div>


                    <div id="erroDeleteModal" class="modal">
                        <div class="modal-content">
                            Você deve selecionar ao menos uma anotação para excluir.
                        </div>
                        <div class="modal-footer">
                            <button class="btn waves-effect waves-light modal-close my-orange" style="margin-right: 10px;">Ok</button>
                        </div>
                    </div>


                    <div id="errorSaveModal" class="modal">
                        <div class="modal-content">
                            Você deve selecionar pelo menos 1 anotação para enviar.
                        </div>
                        <div class="modal-footer">
                            <button class="btn waves-effect waves-light modal-close my-orange" style="margin-right: 10px;">Ok</button>
                        </div>
                    </div>
                </div>
	</body>
</html>
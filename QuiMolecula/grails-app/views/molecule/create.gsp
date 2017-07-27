<%@ page import="br.ufscar.sead.loa.quimolecula.remar.Molecule" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="layout" content="main">
    <meta charset="UTF-8">
    <meta property="user-name" content="${userName}"/>
    <meta property="user-id" content="${userId}"/>

    <g:javascript src="engine/save.js" />
    <g:javascript src="engine/fases.js" />
    <g:javascript src="engine/classe.js" />
    <g:javascript src="engine/tutorial.js" />
    <g:javascript src="engine/jogo.js" />

    <g:external dir="css" file="molecule.css"/>
    <g:external dir="css/engine" file="style.css"/>

    <g:set var="entityName" value="${message(code: 'Molecule.label', default: 'Molecule')}"/>
</head>
<body oncontextmenu="return false;">
    <div class="row">
        <div class="col s12">
            <div class="page-header">
                <h1> Criar Moléculas</h1>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col s12">
            <div class="main-content">
                <div class="widget">
                    <div class="widget-content-white glossed">
                        <div class="padded">
                            <div id="ancora">

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- createModal Structure -->
        <div id="createModal" class="modal remar-modal">
            <div class="modal-content">
                <h4>Criar Molécula</h4>

                <div class="row">
                    <div class="required input-field col s12">
                        <input id="name" class="remar-input validate" name="name" type="text" placeholder="Dióxido de Carbono" />
                        <label for="name" class="active">
                            Nome
                            <span class="required-indicator">*</span>
                        </label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s12">
                        <input id="structure" class="remar-input validate" name="structure" type="text" placeholder="CO2"/>
                        <label for="structure" class="active">
                            Estrutura
                            <span class="required-indicator">*</span>
                        </label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s12">
                        <input id="tip" class="remar-input validate" name="tip" type="text" placeholder="Gás Carbônico"/>
                        <label for="tip">Dica</label>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <a href="#!" id="sendMoleculeButton" class="modal-action modal-close btn waves-effect waves-light remar-orange">Enviar</a>
            </div>
        </div>

        <!-- SuccessModal Structure -->
        <div id="successModal" class="modal remar-modal">
            <div class="modal-content">
                <h4>Sucesso</h4>
                <p>Deseja criar mais moléculas?</p>
            </div>

            <div class="modal-footer">
                <a href="#!" id="createMoreMoleculesButton" class="modal-action modal-close btn waves-effect waves-light remar-orange">Sim</a>
                <a href="${createLink(action: 'index')}" class="btn waves-effect waves-light modal-close my-orange">Não</a>
            </div>
        </div>

        <g:javascript src="materialize.min.js"/>
        <g:javascript src="iframeResizer.contentWindow.min.js"/>
    </div>
</body>
</html>
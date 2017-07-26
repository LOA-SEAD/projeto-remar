<%@ page import="br.ufscar.sead.loa.quimolecula.remar.Molecule" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="layout" content="main">
    <meta charset="UTF-8">
    <meta property="user-name" content="${userName}"/>
    <meta property="user-id" content="${userId}"/>

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
                            <div>
                                <g:javascript src="engine/save.js" />
                                <g:javascript src="engine/fases.js" />
                                <g:javascript src="engine/classe.js" />
                                <g:javascript src="engine/tutorial.js" />
                            </div>
                            <g:javascript id="ancora" src="engine/jogo.js" />
                            <br />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- createModal Structure -->
        <div id="createModal" class="modal">
            <div class="modal-content">
                <div class="row">
                    <div class="input-field col s12">
                        <input id="name" class="remar-field validate" name="name" type="text" />
                        <label for="name">Nome</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s12">
                        <input id="structure" class="remar-field validate tooltiped" name="structure" type="text"
                               data-position="bottom" data-delay="50" data-tooltip="Exemplo: C_2_H_2"/>
                        <label for="structure">Estrutura</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s12">
                        <input id="tip" class="remar-field validate" name="tip" type="text" />
                        <label for="tip">Dica</label>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button id="sendMoleculeButton" class="btn waves-effect waves-light modal-close my-orange">Entendi</button>
            </div>
        </div>

        <!-- SuccessModal Structure -->
        <div id="successModal" class="modal">
            <div class="modal-content">
                <div class="row">
                    <div class="col s12">
                        <p>Deseja criar mais moléculas?</p>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button id="createMoreMoleculesButton" class="btn waves-effect waves-light modal-close my-orange">Sim</button>
                <a href="${createLink(action: 'index')}">
                    <button class="btn waves-effect waves-light modal-close my-orange">Não</button>
                </a>
            </div>
        </div>

        <g:javascript src="materialize.min.js"/>
        <g:javascript src="iframeResizer.contentWindow.min.js"/>
    </div>
</body>
</html>
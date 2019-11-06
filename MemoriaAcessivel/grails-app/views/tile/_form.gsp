<%@ page import="br.ufscar.sead.loa.memoriaacessivel.Tile" %>
<g:javascript>
    GMS = {};
    GMS.RECORDINGS_RESUME_BUTTON_LABEL = "${message(code: 'tile.sound.resume.button.label')}";
    GMS.RECORDINGS_PAUSE_BUTTON_LABEL = "${message(code: 'tile.sound.pause.button.label')}";
</g:javascript>
<g:if test="${edit}">
    <g:hiddenField name="id" value="${tileInstance.id}"/>
</g:if>

<!-- Formulário de criação e edição de peças -->
<div class="input-field col s12">
    <div class="col s12">
        <ul class="collapsible" data-collapsible="accordion">
            <li>
                <div class="collapsible-header active"><i class="material-icons">info</i>Informação sobre as transcrições do texto</div>
                <div class="collapsible-body">
                    <p class="justify-text">
                        As transcrições de texto podem ser gravadas durante a customização ou feito o upload (carregamento) de um áudio.
                        Caso contrário, os áudios podem também serem gerados automaticamente.
                        <br>Deve ser escolhida uma dessas opções para cada texto.
                    </p>
                </div>
            </li>
        </ul>
    </div>



    <!-- Primeira Carta -->
    <div class="row" style="margin-top:5em;">

        <!-- texto da primeira carta -->
        <div class="input-field col s9 fieldcontain ${hasErrors(bean: tileInstance, field: 'content', 'error')} required">
            <!-- <g:textField id="textA" name="textA" class="remar-input" maxlength="50" required="" value="${tileInstance?.textA}"/> -->
            <input id="textA" name="textA" required value="${tileInstance?.textA}" type="text" class="validate remar-input" maxlength="150"/>
            <label for="textA"><g:message code="tile.textA.label" default="Texto Primeira Carta"/>
                <span class="required-indicator">*</span>
            </label>
            <br>
        </div>

        <!-- select box dos audios da primeira carta -->
        <div class="input-field col s3">
            <div class="custom-select remar-orange" >
                <select style="display: block;" id="selectPergunta">
                    <g:if test="${tileInstance.id}"><option value="naoeditar">Não editar o áudio</option></g:if>
                    <option value="gerar">Gerar áudio automaticamente</option>
                    <option value="gravarA">Gravar áudio (microfone)</option>
                    <option value="carregarA">Carregar arquivo (.wav, etc)</option>
                </select>
            </div>
        </div>
    </div>

    <!-- Segunda Carta -->
    <div class="row">

        <!-- texto da primeira carta -->
        <div class="input-field col s9 fieldcontain ${hasErrors(bean: tileInstance, field: 'content', 'error')} required">
            <!-- <g:textField id="textB" name="textB" class="remar-input" maxlength="50" required="" value="${tileInstance?.textB}"/> -->
            <input id="textB" name="textB" required value="${tileInstance?.textB}" type="text" class="validate remar-input" maxlength="150"/>
            <label for="textB"><g:message code="tile.textB.label" default="Texto Segunda Carta"/>
                <span class="required-indicator">*</span>
            </label>
            <br>
        </div>

        <!-- select box dos audios da primeira carta -->
        <div class="input-field col s3">
            <div class="custom-select remar-orange" >
                <select style="display: block;" id="selectPergunta">
                    <g:if test="${tileInstance.id}"><option value="naoeditar">Não editar o áudio</option></g:if>
                    <option value="gerar">Gerar áudio automaticamente</option>
                    <option value="gravarB">Gravar áudio (microfone)</option>
                    <option value="carregarB">Carregar arquivo (.wav, etc)</option>
                </select>
            </div>
        </div>
    </div>
</div>


<div class="row right-align" style="margin-right:2em">
    <a id="back" name="back" class="btn btn-success remar-orange">${message(code:'tile.create.backButton')}</a>

    <input id="submit" type="button" name="submit" class="btn btn-success remar-orange" value="${message(code:'tile.create.sendButton')}"/>
</div>


<g:javascript src="form.js"/>
<script src="https://cdn.rawgit.com/mattdiamond/Recorderjs/08e7abd9/dist/recorder.js"></script>

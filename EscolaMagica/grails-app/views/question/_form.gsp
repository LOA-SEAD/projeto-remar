<%@ page import="br.ufscar.sead.loa.escolamagica.remar.Question" %>
<g:external dir="css" file="question.css"/>
    <div class="row">
        <div class="input-field col s12">
            <label for="title">Pergunta</label>
            <input id="title" name="title" required="" value="${questionInstance?.title}" type="text" class="validate">
        </div>
    </div>

    <div class="row">
        <div class="input-field col s9">
            <label for="answers[0]">Alternativa 1</label>
            <input type="text" class="validate" id="answers[0]" name="answers[0]" required="" value="${questionInstance?.answers[0]}"/>
        </div>
        <div class="col s2">
            <g:if test="${questionInstance?.correctAnswer == 0}">
                <input type="radio" id="radio0${count}" name="correctAnswer" value="0" checked="checked"/>
            </g:if>
            <g:else>
                <input type="radio" id="radio0${count}" name="correctAnswer" value="0" />
            </g:else>
            <label for="radio0${count}">Alternativa correta</label>
        </div>
    </div>

    <div class="row">
        <div class="input-field col s9">
            <label for="answers[1]">Alternativa 2</label>
            <input type="text" class="validate" id="answers[1]" name="answers[1]" required="" value="${questionInstance?.answers[1]}"/>
        </div>
        <div class="col s2">
            <g:if test="${questionInstance?.correctAnswer == 1}">
                <input type="radio" id="radio1${count}" name="correctAnswer" value="1" checked="checked" />

            </g:if>
            <g:else>
                <input type="radio" id="radio1${count}" name="correctAnswer" value="1" />
            </g:else>
            <label for="radio1${count}">Alternativa correta</label>
        </div>
    </div>

    <div class="row">
        <div class="input-field col s9">
            <label for="answers[2]">Alternativa 3</label>
            <input type="text" class="validate" id="answers[2]" name="answers[2]" required="" value="${questionInstance?.answers[2]}"/>
        </div>
        <div class="col s2">
            <g:if test="${questionInstance.correctAnswer == 2}">
                <input type="radio" id="radio2${count}" name="correctAnswer" value="2" checked="checked"/>
            </g:if>
            <g:else>
                <input type="radio" id="radio2${count}" name="correctAnswer" value="2"/>
            </g:else>
            <label for="radio2${count}">Alternativa correta</label>
        </div>
    </div>

    <div class="row">
        <div class="input-field col s9">
            <label for="answers[3]">Alternativa 4</label>
            <input type="text" class="validate" id="answers[3]" name="answers[3]" required="" value="${questionInstance?.answers[3]}"/>
        </div>
        <div class="col s2">
            <g:if test="${questionInstance.correctAnswer == 3}">
                <input type="radio" id="radio3${count}" name="correctAnswer" value="3" checked="checked"/>
            </g:if>
            <g:else>
                <input type="radio" id="radio3${count}" name="correctAnswer" value="3"/>
            </g:else>
            <label for="radio3${count}">Alternativa correta</label>
        </div>
    </div>


    <div class="row">
        <g:if test="${questionInstance.level == "1" }">
            <div class="col s2 offset-s3">
                <input type="radio" id="level1${count}" name="level" value="1" checked="checked"/>
                <label for="level1${count}">Nível 1</label>
            </div>
        </g:if>
        <g:else>
            <div class="col s2 offset-s3">
                <input type="radio" id="level1${count}" name="level" value="1"/>
                <label for="level1${count}">Nível 1</label>
            </div>
        </g:else>
        <g:if test="${questionInstance.level == "2"}">
            <div class="col s2">
                <input type="radio" id="level2${count}" name="level" value="2" checked="checked" />
                <label for="level2${count}">Nível 2</label>
            </div>
        </g:if>
        <g:else>
            <div class="col s2">
                <input type="radio" id="level2${count}" name="level" value="2"  />
                <label for="level2${count}">Nível 2</label>
            </div>
        </g:else>
        <g:if test="${questionInstance.level== "3"}">
            <div class="col s2">
                <input type="radio" id="level3${count}" name="level" value="3" checked="checked" />
                <label for="level3${count}">Nível 3</label>
            </div>
        </g:if>
        <g:else>
            <div class="col s2">
                <input type="radio" id="level3${count}" name="level" value="3" />
                <label for="level3${count}">Nível 3</label>
            </div>
        </g:else>


    </div>





<script>
    $(document).ready(function(){
        // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
        $('select').material_select();
    });

</script>
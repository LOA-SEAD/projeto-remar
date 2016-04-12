<ul class="collapsible" data-collapsible="expandable">
    <li class="c">
        <div class="collapsible-header">
            <div class="my-div centered"><b>Usuário</b></div>
            <div class="my-div centered"><b>Acertos</b></div>
            <div class="my-div centered"><b>Erros</b></div>
            <div class="my-div centered"><b>Aproveitamento</b></div>
        </div>
    </li>
    <g:each in="${users}" var="user">
        <li>
            <div class="collapsible-header" id="${user.value.id}">
                <div class="my-div">${user.value.name}</div>
                <div class="my-div centered">${user.value.hits}</div>
                <div class="my-div centered">${user.value.errors}</div>
                <div class="my-div centered"><g:formatNumber number="${100 * user.value.hits / (user.value.hits + user.value.errors)}" type="number" maxFractionDigits="2" />%</div>
            </div>
            <div class="collapsible-body">
                <ul class="collapsible no-margin">
                    <table style="width: 100%; display: table; border-collapse: collapse; border-spacing: 0;">
                        <thead style="border-bottom: 1px solid #d0d0d0;">
                            <th class="centered">Enunciado</th>
                            <th class="centered">Alternativa A</th>
                            <th class="centered">Alternativa B</th>
                            <th class="centered">Alternativa C</th>
                            <th class="centered">Alternativa D</th>
                            <th class="centered">Resposta Certa</th>
                            <th class="centered">Resposta Escolhida</th>
                            <th class="centered">Timestamp</th>
                        </thead>
                        <tr>
                            <td>'.$question["enunciado"].'</td>
                            <td>'.$question["alternativaa"].'</td>
                            <td>'.$question["alternativab"].'</td>
                            <td>'.$question["alternativac"].'</td>
                            <td>'.$question["alternativad"].'</td>
                            <td class="centered">'.$question["respostacerta"].'</td>
                            <td class="centered">'.$question["resposta"].'</td>
                            <td class="centered">'.$question["timestamp"].'</td>
                        </tr>
                    </table>
                </ul>
            </div>
        </li>
    </g:each>
</ul>

<script>
    $(document).ready(function(){
        $('.collapsible').collapsible();
    });
</script>
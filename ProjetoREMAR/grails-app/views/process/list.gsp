<%--
  Created by IntelliJ IDEA.
  User: deniscapp
  Date: 07/08/15
  Time: 08:29
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <style>
        td a {
            display:block;
            width:100%;
        }
    </style>

    <meta name="layout" content="materialize-layout">

</head>
<body>
    <div class="row cluster">
        <div class="cluster-header">
            <p class="text-teal text-darken-3 left-align margin-bottom">
                <i class="small material-icons left">list</i>Meus processos
            </p>
            <div class="divider"></div>
        </div>
        <div class="row search">
            <div class="input-field col s6">
                <input id="search" type="text" class="validate">
                <label for="search"><i class="fa fa-search"></i></label>
            </div>
        </div>
        <div class="row show developer">
            <article class="row">
                <g:if test="${processes}">
                    <g:render template="process" model="[processes:processes]" />
                </g:if>
                <g:else>
                    <p>Você não possui nenhum jogo em customização. Customize um agora mesmo! :)</p>
                </g:else>
            </article>
        </div>
        <footer class="row">
            <ul class="pagination">
                <li class="disabled"><a href="#!"><i class="material-icons">chevron_left</i></a></li>
                <li class="active"><a href="#!">1</a></li>
                <li class="waves-effect"><a href="#!">2</a></li>
                <li class="waves-effect"><a href="#!">3</a></li>
                <li class="waves-effect"><a href="#!">4</a></li>
                <li class="waves-effect"><a href="#!">5</a></li>
                <li class="waves-effect"><a href="#!"><i class="material-icons">chevron_right</i></a></li>
            </ul>
        </footer>
    </div>
    <script>
        $(document).ready(function(){
            $('.collapsible').collapsible({
                accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
            });
            $('.tooltipped').tooltip({delay: 50});
        });
    </script>
</body>
</html>

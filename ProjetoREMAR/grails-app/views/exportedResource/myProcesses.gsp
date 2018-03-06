<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title><g:message code='exportedResource.label.customizing' default='Em Customização'/></title>
    <meta name="layout" content="materialize-layout">
  </head>

  <body>

  <div class="cluster-header">
      <h4><g:message code="exportedResource.label.myGames" default="Em Customização" /></h4>
      <div class="divider"></div>
  </div>

    <section id="test2" class="col s12"> <!-- start processes-->
        <div class="row search">
            <div class="input-field col s12">
                <input id="search-processes" type="text" class="validate">
                <label for="search-processes">
                    <i class="fa fa-search" data-tooltip="Buscar"></i>
                </label>
            </div>
        </div>
        <div id="showCardsProcess" class="row">
            <article class="row">
                <g:render template="/process/process" model="[processes:processes]" />
            </article>
        </div>
    </section> <!-- finished processes-->
  </body>

</html>

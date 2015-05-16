<%@ page import="br.ufscar.sead.loa.escolamagica.remar.QuestionEscola" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
	</head>
	<body>
		<div class="page-header">
            <h1> Questões - Escola Mágica</h1>
        </div>
        <div class="main-content">
            <div class="widget">
                <h3 class="section-title first-title"><i class="icon-table"></i> Visualização da Questão</h3>
                <div class="widget-content-white glossed">
                    <div class="padded">
                        <div class="table-responsive">
                            <g:if test="${flash.message}">
                                <div class="message" role="status">${flash.message}</div>
                                <br />
                            </g:if>

                            <g:if test="${questionEscolaInstance?.level}">
								<p>
									<b>
										<span id="level-label" class="property-label">
											<g:message code="questionEscola.level.label" default="Nível" />
										</span>
									</b>
									<span class="property-value" aria-labelledby="username-label">
										<g:fieldValue bean="${questionEscolaInstance}" field="level"/>
									</span>
								</p>
							</g:if>

							<g:if test="${questionEscolaInstance?.title}">
								<p>
									<b>
										<span id="level-label" class="property-label">
											<g:message code="questionEscola.title.labelsad" default="Pergunta: " />
										</span>
									</b>
									<span id="answers-label" class="property-label">
										<g:fieldValue bean="${questionEscolaInstance}" field="title"/>
									</span>
								</p>
							</g:if>

							<g:if test="${questionEscolaInstance?.answers}">
								<p>
									<b>
										<span id="level-label" class="property-label">
											<g:message code="questionEscola.level.label" default="Respostas: " />
										</span>
									</b>
<g:fieldValue bean="${questionEscolaInstance}" field="answers"/>
									<span id="answers-label" class="property-label">
									</span>
								</p>
							</g:if>

							<g:if test="${questionEscolaInstance.correctAnswer >= 0}">
								<p>
									<b>
										<span id="level-label" class="property-label">
											<g:message code="questionEscola.level.label" default="Resposta Correta: " />
										</span>
									</b>
									<span id="answers-label" class="property-label">

${questionEscolaInstance.answers[questionEscolaInstance.correctAnswer]} (${questionEscolaInstance.correctAnswer + 1}ª Alternativa)										


									</span>
								</p>
							</g:if>

                        </div>
                    </div>
                </div>
            </div>

            <g:form url="[resource:questionEscolaInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit btn btn-info btn-lg" resource="${questionEscolaInstance}" action="edit">Editar</g:link>
					<g:actionSubmit class="delete btn btn-danger btn-lg" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Tem certeza que deseja excluir?')}');" />
					<g:link class="btn btn-warning btn-lg" action="index">Voltar</g:link>
				</fieldset>
			</g:form>
        </div>
	</body>
</html>

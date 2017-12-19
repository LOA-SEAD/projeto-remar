<%@ page contentType="text/html;charset=UTF-8" %>
<div data-html2canvas-ignore="true" class="modal-wrapper-50">
    <div id="report-modal" class="modal remar-modal">
        <div class="modal-content">
            <h4><g:message code="report.modal.title"/></h4>

            <g:form url="[controller: 'report', action: 'save']">
                <g:render template="/report/form"/>
            </g:form>
        </div>

        <div class="modal-footer">
            <a id="report-fsm-finish" href="#!"
               class="report-fsm-next btn waves-effect waves-light remar-orange hidden">
                <g:message code="default.button.submit.label"/>
            </a>
            <a id="report-fsm-next" href="#!"
               class="report-fsm-next btn waves-effect waves-light remar-orange hidden">
                <g:message code="default.button.next.label"/>
            </a>
            <a id="report-fsm-prev" href="#!"
               class="btn waves-effect waves-light remar-orange hidden">
                <g:message code="default.button.previous.label"/>
            </a>
            <a id="report-fsm-cancel" href="#!"
               class="modal-action modal-close btn waves-effect waves-light remar-orange">
                <g:message code="default.button.cancel.label"/>
            </a>
        </div>
    </div>
</div>
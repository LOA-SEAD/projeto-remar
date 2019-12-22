<%@ page import="br.ufscar.sead.loa.ortotetris.remar.Word" %>

<g:if test="${WordMessage}">
    <div id="MessageDivTemplate" align="center" class="message">${WordMessage}</div>
</g:if>

<script type="text/javascript" defer="defer">
    $(document).ready(function() {
        $("#MessageDivTemplate").delay(1000).fadeOut(500);
    });
</script>
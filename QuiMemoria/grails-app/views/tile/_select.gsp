<%@ page import="br.ufscar.sead.loa.quimemoria.Tile" %>

<g:if test="${tileList}">
    <select>
        <option value="" disabled selected>Escolha um par de peças...</option>
        <g:each in="${tileList}" var="tile">
            <option value="${tile.id}"> ${tile.content} </option>
        </g:each>
    </select>
</g:if>
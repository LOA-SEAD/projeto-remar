<%@ page import="br.ufscar.sead.loa.quimemoria.Tile" %>

<g:if test="${tileList}">
    <label style="left: 0">Escolha um par de peças para visualizar</label>
    <select>
        <g:each in="${tileList}" var="tile">
            <option value="${tile.id}"> ${tile.content} </option>
        </g:each>
    </select>
</g:if>
<%@ page import="br.ufscar.sead.loa.memoriaacessivel.Tile" %>

<g:if test="${tileList}">
    <div class="row valign-wrapper no-margin full-height">
        <div class="col s10 no-margin no-padding">
            <select>
                <g:each in="${tileList}" var="tile">
                    <option value="${tile.id}"> ${tile.content} </option>
                </g:each>
            </select>
        </div>
    </div>
</g:if>
<%--
  Created by IntelliJ IDEA.
  User: matheus
  Date: 2/17/16
  Time: 1:59 PM
--%>

<ul class="pagination">

    <g:if test="${pageCount > 0}">

        <g:if test="${currentPage != 1}">
            <li class="waves-effect"><a href="?max=${max}&offset=${threshold * (currentPage - 2)}"><i class="material-icons">chevron_left</i></a></li>
        </g:if>
        <g:else>
            <li class="waves-effect"><a href="#!"><i class="material-icons">chevron_left</i></a></li>
        </g:else>

        <g:each in="${1..pageCount}" var="page">
            <g:if test="${page == currentPage}">
                <li class="active"><a href="#!">${page}</a></li>
            </g:if>
            <g:else>
                <a href="?max=${max}&offset=${threshold * (page - 1)}"><li class="waves-effect">${page}</li></a>
            </g:else>
        </g:each>

        <g:if test="${currentPage != pageCount}">
            <li class="waves-effect"><a href="?max=${max}&offset=${threshold * (currentPage)}"><i class="material-icons">chevron_right</i></a></li>
        </g:if>
        <g:else>
            <li class="waves-effect"><a href="#!"><i class="material-icons">chevron_right</i></a></li>
        </g:else>

    </g:if>
</ul>
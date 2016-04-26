<%--
  Created by IntelliJ IDEA.
  User: matheus
  Date: 2/17/16
  Time: 1:59 PM
--%>

<ul class="pagination">

    <g:if test="${pageCount > 0}">

        <g:if test="${currentPage != 1}">
            <li class="waves-effect">
                <a class="next-page" data-max="${max}" data-offset="${threshold * (currentPage - 2)}" href="#!">
                    <i class="material-icons">chevron_left</i>
                </a>
            </li>
        </g:if>
        <g:else>
            <li class="waves-effect"><a href="#!"><i class="material-icons">chevron_left</i></a></li>
        </g:else>

        <g:each in="${1..pageCount}" var="page">
            <g:if test="${page == currentPage}">
                <li class="active"><a href="#!">${page}</a></li>
            </g:if>
            <g:else>
                <a class="next-page" data-max="${max}" data-offset="${threshold * (page - 1)}" href="#!">
                    <li class="waves-effect">${page}</li>
                </a>
            </g:else>
        </g:each>

        <g:if test="${currentPage != pageCount}">
            <li class="waves-effect">
                <a class="next-page" data-max="${max}" data-offset="${threshold * (currentPage)}" href="#!">
                    <i class="material-icons">chevron_right</i>
                </a>
            </li>
        </g:if>
        <g:else>
            <li class="waves-effect"><a href="#!"><i class="material-icons">chevron_right</i></a></li>
        </g:else>

    </g:if>
</ul>
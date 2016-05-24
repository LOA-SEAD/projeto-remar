<%--
  Created by IntelliJ IDEA.
  User: matheus
  Date: 2/17/16
  Time: 1:59 PM
--%>

<ul class="pagination">
    <g:if test="${tPageCount > 0}">

        <g:if test="${tCurrentPage != 1}">
            <li class="waves-effect">
                <a class="t-next-page" data-max="${tMax}" data-offset="${tThreshold * (tCurrentPage - 2)}" href="#!">
                    <i class="material-icons">chevron_left</i>
                </a>
            </li>
        </g:if>
        <g:else>
            <li class="waves-effect"><a href="#!"><i class="material-icons">chevron_left</i></a></li>
        </g:else>

        <g:each in="${1..tPageCount}" var="page">
            <g:if test="${page == tCurrentPage}">
                <li class="active"><a href="#!">${page}</a></li>
            </g:if>
            <g:else>
                <a class="tab-next-page" data-max="${tMax}" data-offset="${tThreshold * (page - 1)}" href="#!">
                    <li class="waves-effect">${page}</li>
                </a>
            </g:else>
        </g:each>

        <g:if test="${tCurrentPage != tPageCount}">
            <li class="waves-effect">
                <a class="tab-next-page" data-max="${tMax}" data-offset="${tThreshold * (tCurrentPage)}" href="#!">
                    <i class="material-icons">chevron_right</i>
                </a>
            </li>
        </g:if>
        <g:else>
            <li class="waves-effect"><a href="#!"><i class="material-icons">chevron_right</i></a></li>
        </g:else>

    </g:if>
</ul>
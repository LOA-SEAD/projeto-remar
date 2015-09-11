<%--
  Created by IntelliJ IDEA.
  User: loa
  Date: 10/06/15
  Time: 08:32
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="new-main-inside">
    <title></title>

</head>
<body>
    <div class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box box-body box-info">
                    <div class="box-header with-border">
                        %{--<h3 class="box-title">--}%
                            %{--<i class="fa fa-list-alt"></i>--}%
                            %{--Tarefas pendentes--}%
                        %{--</h3>--}%
                    </div><!-- /.box-header -->
                    <div class="box-body">
                        <div class="direct-chat-messages page-size" >
                            <tbody>
                                <g:each in="${list}" status="i" var="task">
                                    <table>
                                        <tr>
                                            <td><g:link action="--"> ${task.getName()}  </g:link> <br>
                                                ${task.assignee}

                                            </td>

                                        </tr>

                                    </table>
                                </g:each>
                            </tbody>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
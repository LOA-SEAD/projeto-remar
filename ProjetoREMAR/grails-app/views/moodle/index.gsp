<%--
  Created by IntelliJ IDEA.
  User: matheus
  Date: 9/15/15
  Time: 5:06 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="new-main-inside">
    <title>Moodle</title>
</head>

<body>

<div class="content">
    <div class="row">
        <article class="row">
            <div class="col-md-12" align="center">
                <div class="box box-body box-info" style="width:40%;" align="center" >
                    <div class="box-header with-border">
                        <h3 class="box-title">
                            <i class="fa fa-graduation-cap"></i>
                            Vincular conta ao Moodle
                        </h3>
                    </div><!-- /.box-header -->
                    <div class="box-body">
                        <div class="direct-chat-messages page-size" style="text-align: left;"  >

                            <form action="/moodle/link">
                                <div class="form-group has-feedback" >
                                     <label>Moodle:</label>
                                     <g:select name="domain" from="${moodleInstanceList}" optionValue="name" optionKey="domain" class="form-control-remar" />
                                </div>
                                <div class="form-group has-feedback" align="center" >
                                    <label></label>
                                    <input type="submit" value="Enviar" class="btn btn-primary btn-block btn-flat" style="max-width: 30%;">
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </article>
    </div>
</div>

</body>
</html>
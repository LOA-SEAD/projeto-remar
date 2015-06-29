<html>
<head>
    <meta name='layout' content='main'/>
    <title><g:message code="springSecurity.login.title"/></title>

</head>

<body>
<div class="page-header">
    <h1> Página de Login</h1>
</div>
<div class="main-content">
    <div class="widget">
        <h3 class="section-title first-title"><i class="icon-user"></i> Confirme o email</h3>
        <div class="widget-content-white glossed">
            <div class="padded">
                <g:if test='${flash.message}'>
                    <div class='login_message'>${flash.message}</div>
                </g:if>
                <g:form action="checkEmail" controller="user" method='POST' id='resetPassword' class='cssform' autocomplete='off'>
                    <div class="form-group">
                        <label for="username">Email:</label>
                        <input type="text" class="form-control" name="email" id="email" required=""/>
                    </div>
                    <div>
                        <p>
                            <input type='submit' id="submit" class="btn btn-info btn-lg" value="Enviar"/>
                            %{--value='${message(code: "springSecurity.login.button")}--}%
                        </p>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

    $(function() {
        document.getElementById('menu-latera').style.display = "none";
    });
</script>
</body>
</html>

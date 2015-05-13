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
                <h3 class="section-title first-title"><i class="icon-table"></i> Por favor, faça seu login</h3>
                <div class="widget-content-white glossed">
                    <div class="padded">
                        <g:if test='${flash.message}'>
                            <div class='login_message'>${flash.message}</div>
                        </g:if>
                        <form action='${postUrl}' method='POST' id='loginForm' class='cssform' autocomplete='off'>
                            <div class="form-group">
                                <label for="username">Usuário:</label>
                                <input type="text" class="form-control" name="j_username" id="username" required=""/>
                            </div>
                            <div class="form-group">
                                <label for='password'>Senha:</label>
                                <input type='password' class='form-control' name='j_password' id='password' required=""/>
                            </div>
                            <div class="form-group">
                                <p id="remember_me_holder">
                                    <input type='checkbox' class='chk' name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>
                                    <label for='remember_me'>Lembrar-me</label>
                                </p>

                                <p>
                                    <input type='submit' id="submit" class="btn btn-info btn-lg" value='${message(code: "springSecurity.login.button")}'/>
                                </p>
                            </div>
                        </form>
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

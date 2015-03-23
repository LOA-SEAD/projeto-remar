<html>
<head>
    <g:javascript src="loginForm.js"></g:javascript>
	<meta name='layout' content='main'/>
	<title><g:message code="springSecurity.login.title"/></title>
	<style type='text/css' media='screen'>
    /* Login Container (default to float:right) */
    #loginContainer {
        position:relative;
        float:right;
        font-size:12px;
    }

    /* Login Button */
    #loginButton {
        display:inline-block;
        float:right;
        background:#d2e0ea url('${resource(dir:"images", file: "buttonbg.png")}') repeat-x;
        border:1px solid #899caa;
        border-radius:3px;
        -moz-border-radius:3px;
        position:relative;
        z-index:30;
        cursor:pointer;
    }

    /* Login Button Text */
    #loginButton span {
        color:#445058;
        font-size:14px;
        font-weight:bold;
        text-shadow:1px 1px #fff;
        padding:7px 29px 9px 10px;
        background:url('${resource(dir:"images", file: "loginArrow.png")}') no-repeat 53px 7px;
        display:block
    }

    #loginButton:hover {
        background:url('${resource(dir:"images", file: "buttonbgHover.png")}') repeat-x;
    }

    /* Login Box */
    #loginBox {
        position:absolute;
        top:34px;
        right:0;
        display:none;
        z-index:29;
    }

    /* If the Login Button has been clicked */
    #loginButton.active {
        border-radius:3px 3px 0 0;
    }

    #loginButton.active span {
        background-position:53px -76px;
    }

    /* A Line added to overlap the border */
    #loginButton.active em {
        position:absolute;
        width:100%;
        height:1px;
        background:#d2e0ea;
        bottom:-1px;
    }

    /* Login Form */
    #loginForm {
        width:248px;
        border:1px solid #899caa;
        border-radius:3px 0 3px 3px;
        -moz-border-radius:3px 0 3px 3px;
        margin-top:-1px;
        background:#d2e0ea;
        padding:6px;
    }

    #loginForm fieldset {
        margin:0 0 12px 0;
        display:block;
        border:0;
        padding:0;
    }

    fieldset#body {
        background:#fff;
        border-radius:3px;
        -moz-border-radius:3px;
        padding:10px 13px;
        margin:0;
    }

    #loginForm #checkbox {
        width:auto;
        margin:1px 9px 0 0;
        float:left;
        padding:0;
        border:0;
        *margin:-3px 9px 0 0; /* IE7 Fix */
    }

    #body label {
        color:#3a454d;
        margin:9px 0 0 0;
        display:block;
        float:left;
    }

    #loginForm #body fieldset label {
        display:block;
        float:none;
        margin:0 0 6px 0;
    }

    /* Default Input */
    #loginForm input {
        width:92%;
        border:1px solid #899caa;
        border-radius:3px;
        -moz-border-radius:3px;
        color:#3a454d;
        font-weight:bold;
        padding:8px 8px;
        box-shadow:inset 0px 1px 3px #bbb;
        -webkit-box-shadow:inset 0px 1px 3px #bbb;
        -moz-box-shadow:inset 0px 1px 3px #bbb;
        font-size:12px;
    }

    /* Sign In Button */
    #loginForm #login {
        width:auto;
        float:left;
        background:#339cdf url('${resource(dir:"images", file: "loginbuttonbg.png")}') repeat-x;
        color:#fff;
        padding:7px 10px 8px 10px;
        text-shadow:0px -1px #278db8;
        border:1px solid #339cdf;
        box-shadow:none;
        -moz-box-shadow:none;
        -webkit-box-shadow:none;
        margin:0 12px 0 0;
        cursor:pointer;
        *padding:7px 2px 8px 2px; /* IE7 Fix */
    }

    /* Forgot your password */
    #loginForm span {
        text-align:center;
        display:block;
        padding:7px 0 4px 0;
    }

    #loginForm span a {
        color:#3a454d;
        text-shadow:1px 1px #fff;
        font-size:12px;
    }

    input:focus {
        outline:none;
    }
	</style>
</head>

<body>
<div>
	<div class='inner'>
		<div class='fheader'><g:message code="springSecurity.login.header"/></div>

		<g:if test='${flash.message}'>
			<div class='login_message'>${flash.message}</div>
		</g:if>
        <div id="bar">
            <div id="container">
        <div id="loginContainer">
            <a href="#" id="loginButton"><span>Login</span><em></em></a>
            <div style="clear:both"></div>
            <div id="loginBox">

                <form action='${postUrl}' method='POST' id='loginForm' class='cssform' autocomplete='off'>
                    <fieldset id="body">

                <fieldset>
				    <label for='username'><g:message code="springSecurity.login.username.label"/>:</label>
				    <input type='text' class='text_' name='j_username' id='username'/>
                </fieldset>


			<fieldset>
				<label for='password'><g:message code="springSecurity.login.password.label"/>:</label>
				<input type='password' class='text_' name='j_password' id='password'/>
            </fieldset>

                <input type='submit' id="login" value='${message(code: "springSecurity.login.button")}'/>
                        <p id="remember_me_holder">
				<input type='checkbox' class='chk' name='${rememberMeParameter}' id='checkbox' <g:if test='${hasCookie}'>checked='checked'</g:if>/>
				<label for='checkbox'><g:message code="springSecurity.login.remember.me.label"/></label>
			</p>
                </fieldset>



                    </form>
                </div>
            </div>
        </div>
		</form>
	</div>
    </div>
    </div>
</body>
<script type='text/javascript'>
	<!--
	(function() {
		document.forms['loginForm'].elements['j_username'].focus();
	})();
	// -->
</script>
</body>
</html>

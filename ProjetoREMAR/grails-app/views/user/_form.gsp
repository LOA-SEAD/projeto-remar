<div class="input-field">
    <i class="material-icons small">info</i> <span class="align-with-icon-small">Todos os campos são obrigatórios</span>
</div>

<div class="row">
    <div class="input-field col s12">
        <i class="material-icons prefix">person</i>
        <input id="first-name" name="firstName" type="text" class="validate"/>
        <label for="first-name">Nome</label>
    </div>

    <div class="input-field col s12">
        <i class="material-icons prefix">person</i>
        <input id="last-name" name="lastName" type="text"/>
        <label for="last-name">Sobrenome</label>
    </div>


    <div class="input-field col s12">
        <i class="material-icons prefix">email</i>
        <input id="email" name="email" type="text"/>
        <label for="email">Email</label>
    </div>

    <div class="input-field col s12">
        <i class="material-icons prefix">account_circle</i>
        <input id="username" name="username" type="text"/>
        <label for="username">Nome de usuário</label>
    </div>

    <div class="input-field col s12">
        <i class="material-icons prefix">lock</i>
        <input id="password" name="password" type="password"/>
        <label for="password">Senha</label>
    </div>

    <div class="input-field col s12">
        <i class="material-icons prefix">lock</i>
        <input id="confirm-password" name="confirm_password" type="password"/>
        <label for="confirm-password">Confirme sua senha</label>
    </div>

    <div class="input-field col s12">
        <i class="material-icons prefix">face</i>
        <select id="select">
            <option value="" disabled selected>Selecione</option>
            <option value="male">Masculino</option>
            <option value="female">Feminino</option>
        </select>
        <label for="select">Sexo</label>
    </div>

    <div class="input-field col s12">
        <div class="g-recaptcha" data-sitekey="6LdA8QkTAAAAANzRpkGUT__a9B2zHlU5Mnl6EDoJ"> </div>
        <g:if test='${flash.message}'>
            ${flash.message}
        </g:if>
        <recaptcha:script/>
    </div>
</div>

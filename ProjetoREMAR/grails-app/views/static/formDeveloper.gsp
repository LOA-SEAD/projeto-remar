<%--
  Created by IntelliJ IDEA.
  User: loa
  Date: 25/06/15
  Time: 11:04
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="materialize-layout">
</head>
<body>

    <div class="row">
        <div class="col s12">
            <div class="card">
                <div class="card-content">
                    <span class="card-title left-align black-text">Tornar-se um desenvolvedor</span>
                    <g:form action="makeDeveloper" controller="user" params="">
                        <div class="row">
                            <div class="input-field col s12">
                                <i class="material-icons prefix">person</i>
                                <input type="text" name="fullName" id="fullName" value="${fullname}" required />
                                <label for="fullName">Nome Completo</label>
                            </div>

                            <div class="input-field col s12 m6">
                                <i class="material-icons prefix">store_mall_directory</i>
                                <input type="text" name="state" id="state" required />
                                <label for="state">Estado</label>
                            </div>

                            <div class="input-field col s12 m6">
                                <i class="material-icons prefix">store_mall_directory</i>
                                <input type="text" name="city" id="city" required />
                                <label for="city">Cidade</label>
                            </div>

                            <div class="input-field col s12">
                                <i class="material-icons prefix">comment</i>
                                <textarea id="reasons" name="reasons" class="materialize-textarea" required ></textarea>
                                <label for="reasons">Motivos</label>
                            </div>

                            <div class="input-field col s12">
                                <input type="checkbox" name="agree" id="agree" />
                                <label for="agree">Eu concordo com os termos adicionais presentes nos <a>Termos e privacidade</a> do remar.</label>
                            </div>

                            <div class="clearfix"></div>
                            <div class="input-field center-align" style="margin-top: 30px;">
                                <button id="submit" class="btn waves-effect waves-light tooltiped my-orange" type="submit">Enviar</button>
                            </div>
                        </div>
                    </g:form>
                </div>
            </div>
        </div>
    </div>
</body>
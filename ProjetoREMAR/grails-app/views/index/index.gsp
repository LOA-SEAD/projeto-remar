<%--
  Created by IntelliJ IDEA.
  User: marcus
  Date: 26/08/15
  Time: 13:32
--%>
<g:applyLayout name="base">
    <script>
        $(function() {
            $(".button-collapse").sideNav();
        });
    </script>
    <header>
        <div class="navbar-fixed">
            <nav class="dark-brown">
                <div class="nav-wrapper">
                    <!-- Menu for large displays -->
                    <ul class="left hide-on-med-and-down">
                        <li class="logo">
                            <a href="/">
                                <img src="/images/logo/logo-remar-branco-transparente.png"  />
                            </a>
                        </li>
                    </ul>
                    <ul class="right hide-on-med-and-down">
                        <li>
                            <a href="/">GT-REMAR</a>
                        </li>
                        <li>
                            <a href="/index/info">Mais informações</a>
                        </li>
                        <li>
                            <a href="https://remar.readme.io/docs">Documentação</a>
                        </li>
                        <li>
                            <a href="/login">Entrar</a>
                        </li>
                    </ul>

                    <!-- Menu for small displays -->
                    <ul class="hide-on-large-only">
                        <li class="logo left">
                            <a data-activates="slide-out" class="button-collapse menu-sidebar-collapse my-btn">
                                <i class="mdi-navigation-menu"></i>
                            </a>
                        </li>
                        <li class="logo right">
                            <a href="/">
                                <img src="/images/logo/favicon.png" class="logo-min no-margin-right" />
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
    </header>

    <aside id="left-sidebar-nav">
        <ul id="slide-out" class="side-nav leftside-navigation">
            <li>
                <a href="/" class="waves-effect">
                    <i class="material-icons">help</i>
                    GT-REMAR
                </a>
            </li>
            <li>
                <a href="/index/info" class="waves-effect">
                    <i class="material-icons">info</i>
                    Mais informações
                </a>
            </li>
            <li>
                <a href="https://remar.readme.io/docs" class="waves-effect">
                    <i class="material-icons">description</i>
                    Documentação
                </a>
            </li>
            <li>
                <a href="/login" class="waves-effect">
                    <i class="fa fa-sign-in"></i>
                    Entrar
                </a>
            </li>
        </ul>
    </aside>

    <div class="content-index" >
        <div id="wrapper">
            <section id="content">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div style="margin-bottom: 30px;">
                                <a href="http://www.loa.sead.ufscar.br/" target="_blank">
                                <img src="../images/logo/loa-topo.png"/>
                                </a>
                            </div>

                            <div align="center">
                                <img src="/assets/img/logo/logo-remar-preto-transparente.png" width="450px;" align="center" style="margin-bottom: 15px;"/>
                            </div>

                            <p class="center">Recursos Educacionais Multiplataforma Abertos na Rede</p>

                            <h3 id="gt-remar" style="text-align: left;">GT-REMAR</h3>
                            <p style="text-align: justify">
                                Este projeto encontra-se no contexto dos grupos de trabalho (GTs) Temáticos em EAD (sub-tema: Universidade Aberta OnLine) da RNP.
                                O GT-REMAR tem como objetivo facilitar e ampliar a construção e o reuso de recursos educacionais abertos (REA), por meio de um serviço,
                                na forma de uma plataforma web, que ofereça ferramentas que facilitem a construção e a customização de REA, seguindo diretrizes que favoreçam
                                o reuso, a disponibilização desses recursos em diferentes plataformas, bem como a integração com ambientes virtuais de aprendizagem. Espera-se obter
                                como resultados: (i) um conjunto de diretrizes para o desenvolvimento de REA reutilizáveis, adaptáveis, multiplataforma e acessíveis; (ii) um protótipo
                                da plataforma, que deverá ser testado e validado por meio do desenvolvimento e adaptação de REA pelo grupo proponente, em conjunto com instituições parceiras.
                            </p>

                            <h3 id="description" style="text-align: left;">Descrição</h3>
                            <p style="text-align: justify">
                                O acesso aberto a recursos educacionais é um requisito essencial
                                para a educação democrática, de qualidade, sustentável e aberta,
                                em qualquer modalidade (presencial, a distância, híbrida) e em
                                todos os níveis de formação. Além do acesso, o reuso de recursos
                                educacionais deve ser promovido, considerando que o desenvolvimento
                                desses recursos, em geral, é um processo bastante dispendioso e requer
                                um trabalho conjunto entre especialistas do conteúdo e uma equipe
                                multidisciplinar, sobretudo quando consideramos os recursos educacionais
                                interativos e que integram diferentes mídias e tecnologias. Dessa
                                forma, este projeto tem como intuito ampliar o acesso aos recursos
                                educacionais abertos, por meio de um serviço, na forma de uma plataforma
                                web, que ofereça ferramentas que facilitem a construção e customização
                                de REA seguindo diretrizes que favoreçam o reuso, bem como a
                                disponibilização desses recursos em diferentes plataformas e a
                                integração com ambientes virtuais de aprendizagem.
                            </p>
                        </div>
                    </div>
                </div>
                <!-- /.container -->

                <footer>
                    <div class="center" style="margin-top: 250px;">
                        <p>Copyright &copy; REMAR 2015</p>
                    </div>
                </footer>
            </section>
        </div>
</g:applyLayout>
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
                            %{--<p>Note: You may need to adjust some CSS based on the size of your logo. The default logo size is 150x50 pixels.</p>--}%

                            <h3 id="architecture" style="text-align:left;">Arquitetura</h3>
                            <p style="text-align: justify">
                                Um esboço da arquitetura da plataforma proposta é apresentado abaixo.
                                Os usuários da plataforma poderão realizar a autoria e/ou adaptação e
                                posterior publicação de instâncias de recursos educacionais abertos (REA),
                                segundo um conjunto de diretrizes para a construção de REA que serão estabelecidas
                                para este serviço. A plataforma proposta disponibilizará, por meio de duas
                                ferramentas (de autoria e de publicação), um conjunto de funcionalidades que visam
                                facilitar: (i) a construção de REA utilizando tecnologia HTML5; (ii) a adaptação
                                dos componentes constituintes do REA para o atendimento de diferentes necessidades
                                (adaptação de conteúdo, interface para dispositivos móveis, acessibilidade); (iii)
                                a geração e publicação de instâncias dos REA para plataformas web, móvel, desktop;
                                (iv) a integração de REA com ambientes virtuais de aprendizagem. As duas primeiras
                                funcionalidades (construção e adaptação) estarão sob a responsabilidade da ferramenta
                                de autoria, enquanto as duas últimas (geração/publicação para múltiplas plataformas e
                                integração com AVA) sob a responsabilidade da ferramenta de publicação.
                            </p>

                            <div class="container-white" style="text-align: center;">
                                <img src="../images/architecture.png" />
                            </div>

                            <h3 id="team" style="text-align:left;">Equipe</h3>
                            <br />
                            <p>Coordenação</p>
                            <ul class="with-marker">
                                <li><a href="http://lattes.cnpq.br/5845245549777383" target="_blank">Delano Medeiros Beder</a>, Departamento de Computação, UFSCar</li>
                                <li><a href="http://lattes.cnpq.br/8235968002513082" target="_blank">Joice Lee Otsuka</a>, Departamento de Computação, UFSCar</li>
                            </ul>

                            <p>Equipe de Desenvolvimento</p>
                            <ul class="with-marker">
                                <li>Lucas Fernando Bocanegra, Graduando em Ciência da Computação, UFSCar</li>
                                <li>Marcus Marangon Mourão, Graduando em Ciência da Computação, UFSCar</li>
                                <li>Matheus Vieira Fernandes, Graduando em Ciência da Computação, UFSCar</li>
                                <li><a href="http://lattes.cnpq.br/3936850286110811" target="_blank">Rener Baffa da Silva</a>, Mestrando em Ciência da Computação, UFSCar</li>
                            </ul>


                            <p style="margin-left: 5px;">Ex-desenvolvedores:</p>
                            <ul class="with-marker">
                                <li><a href="http://lattes.cnpq.br/8675003419316612" target="_blank">Alex Roberto Guido</a>, Pós-Graduando em Ciência da Computação, UFSCar</li>
                                <li>Denis Cappelini, Graduando em Ciência da Computação, UFSCar</li>
                                <li><a href="http://lattes.cnpq.br/9470649292364278" target="_blank">Pablo Bizzi Mahmud</a>, Pós-Graduando em Ciência da Computação, UFSCar</li>
                                <li><a href="http://lattes.cnpq.br/3111439904701090" target="_blank">Rogerio Augusto Bordini</a>, Pós-Graduando em Educação, UFSCar</li>
                            </ul>

                            <p>Pesquisadores Colaboradores<p>
                            <ul class="with-marker">
                                <li><a href="http://lattes.cnpq.br/1515286597269486" target="_blank">Daniel Ribeiro Silva Mill</a>, Departamento de Educação, UFSCar</li>
                                <li><a href="http://lattes.cnpq.br/1543348404865052" target="_blank">Dulce Márcia Cruz</a>, Departamento Metodologia de Ensino (MEN), UFSC</li>
                                <li><a href="http://lattes.cnpq.br/2727662627646050" target="_blank">Fernanda M. Pereira Freire</a>, Núcleo de Informática Aplicada à Educação, UNICAMP</li>
                                <li><a href="http://lattes.cnpq.br/0131332176384646" target="_blank">Flavia Linhalis Arantes</a>, Núcleo de Informática Aplicada à Educação, UNICAMP</li>
                                <li><a href="http://lattes.cnpq.br/5340922290331025" target="_blank">Izabel Patrícia Meister</a>, Secretaria de Educação a Distância, UNIFESP</li>
                                <li><a href="http://lattes.cnpq.br/9826026025118073" target="_blank">Marilde Prado Santos</a>, Departamento de Computação, UFSCar</li>
                                <li><a href="http://lattes.cnpq.br/0130140163490918" target="_blank">Silvar Ferreira Ribeiro</a>, Departamento de Ciência Humanas, UNEB</li>
                                <li><a href="http://lattes.cnpq.br/0185144417072417" target="_blank">Sílvia Zem-Mascarenhas</a>, Departamento de Enfermagem, UFSCar</li>
                                <li><a href="http://lattes.cnpq.br/0246540741711761" target="_blank">Tel Amiel</a>, Núcleo de Informática Aplicada à Educação, UNICAMP</li>
                                <li><a href="http://lattes.cnpq.br/3246940231681306" target="_blank">Valeria Sperduti Lima</a>, Secretaria de Educação a Distância, UNIFESP</li>
                            </ul>

                            <h3 id="partners" style="text-align:left;">Parceiros</h3>
                            <p style="text-align: justify">
                                Instituições
                            </p>
                            <div class="container-white" style="text-align: center">
                                <div>
                                    <a style="padding: 2px;" href="http://www.ufscar.br" target="_blank" rel="prettyPhoto" title="Universidade Federal de São Carlos">
                                        <img src="../images/partners/ufscar.png" alt="UFSCar">
                                    </a>
                                    <a href="http://www.unicamp.br/unicamp/" target="_blank" rel="prettyPhoto" title="Universidade Estadual de Campinas">
                                        <img src="../images/partners/unicamp.png" alt="UNICAMP">
                                    </a>
                                    <a href="http://www.unifesp.br/" target="_blank" rel="prettyPhoto" title="Universidade Federal de São Paulo">
                                        <img src="../images/partners/unifesp.png" alt="UNIFESP">
                                    </a>
                                    <a href="http://ufsc.br/" target="_blank" rel="prettyPhoto" title="Universidade Federal de Santa Catarina">
                                        <img src="../images/partners/ufsc.png" alt="UFSC">
                                    </a>
                                    <a href="http://www.uneb.br/" target="_blank" rel="prettyPhoto" title="Universidade do Estado da Bahia">
                                        <img src="../images/partners/uneb.png" alt="UNEB">
                                    </a>
                                </div>
                            </div>
                            <p>
                            </p>
                            <p style="text-align: justify">
                                Investimento
                            </p>
                            <div class="container-white" style="text-align: center">
                                <div class="container-custom">
                                    <a href="http://www.rnp.br/" target="_blank" rel="prettyPhoto" title="Rede Nacional de Ensino e Pesquisa">
                                        <img src="../images/partners/rnp.png" alt="RNP">
                                    </a>
                                </div>
                            </div>


                            <h3 id="contact" style="text-align:left;">Contato</h3>
                            <p style="text-align: justify">
                                Email: remar@sead.ufscar.br
                            </p>
                            <p style="text-align: justify">
                                Endereço: Universidade Federal de São Carlos, At3 - Sala 54 - São Carlos - SP
                            </p>
                        </div>
                    </div>
                    <!-- /.container -->

                </div>
                <footer>
                    <div class="center" style="margin-top: 250px;">
                        <p>Copyright &copy; REMAR 2015</p>
                    </div>
                </footer>
            </section>
        </div>
    </div>
</g:applyLayout>
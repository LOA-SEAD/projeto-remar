<%--
  Created by IntelliJ IDEA.
  User: marcus
  Date: 26/08/15
  Time: 13:32
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Logo Nav - REMAR</title>

    <!-- Bootstrap Core CSS -->
    <link href="../assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="${resource(dir: 'assets/css', file: 'bootstrap.css')}" rel="stylesheet">
    %{--<link href="${resource(dir: 'assets/css', file: 'grayscale.css')}" rel="stylesheet">--}%
    %{--<link href="${resource(dir: 'assets/css', file: 'icomoon.css')}"  rel="stylesheet">--}%

    <!-- Custom CSS -->
    <link href="../assets/css/logo-nav.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>

<![endif]-->
</head>


<!-- Navigation -->
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container">


            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">
                    <img src="http://placehold.it/150x50&text=Logo" alt="">
                </a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li>
                        <a class="page-scroll" href="#gt-remar">GT-REMAR</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#description">Descrição</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#architecture">Arquitetura</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#team">Equipe</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#partners">Parceiros</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#contact">Contato</a>
                    </li>
                    <li>
                        <g:link class="btn-login" controller="login">Entrar</g:link>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

    <!-- Page Content -->
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div style="margin-bottom: 30px;">
                        <a href="http://www.loa.sead.ufscar.br/" target="_blank">
                            <img src="../images/logo/loa-topo.png"/>
                        </a>
                </div>
                <h1>REMAR</h1>
                <p>Recursos Educacionais Multiplataforma Abertos na Rede</p>
                <p>Note: You may need to adjust some CSS based on the size of your logo. The default logo size is 150x50 pixels.</p>

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
                <p>Coordenação</p>

                <ul>
                    <li><a href="http://lattes.cnpq.br/5845245549777383" target="_blank">Delano Medeiros Beder</a>, Departamento de Computação, UFSCar</li>
                    <li><a href="http://lattes.cnpq.br/8235968002513082" target="_blank">Joice Lee Otsuka</a>, Departamento de Computação, UFSCar</li>
                </ul>

                <p>Equipe de Desenvolvimento</p>

                <ul>
                    <li><a href="http://lattes.cnpq.br/8675003419316612" target="_blank">Alex Roberto Guido</a>, Pós-Graduando em Ciência da Computação, UFSCar</li>
                    <li>Denis Cappelini, Graduando em Ciência da Computação, UFSCar</li>
                    <li><a href="http://lattes.cnpq.br/9470649292364278" target="_blank">Pablo Bizzi Mahmud</a>, Pós-Graduando em Ciência da Computação, UFSCar</li>
                    <li><a href="http://lattes.cnpq.br/3111439904701090" target="_blank">Rogerio Augusto Bordini</a>, Pós-Graduando em Educação, UFSCar</li>
                </ul>

                <p>Pesquisadores Colaboradores<p>
                <ul>
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
    </div>
    <!-- /.container -->

    <!-- jQuery -->
    <script src="../assets/js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="../assets/js/bootstrap.min.js"></script>
    <script src="../assets/js/jquery.easing.1.3.js"></script>
    <script type="text/javascript" src="${resource(dir: 'assets/js', file: 'grayscale.js')}"></script>

    <footer>
        <div class="container text-center" style="margin-top: 30px;">
            <p>Copyright &copy; Your Website 2014</p>
        </div>
    </footer>

</body>
</html>

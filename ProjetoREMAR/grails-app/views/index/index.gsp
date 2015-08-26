<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<title>REMAR</title>
	<link rel="shortcut icon" href="${resource(dir: 'assets/img/logo', file: 'icone-remar_v2.ico')}" type="image/x-icon">

	<link href='http://fonts.googleapis.com/css?family=Sniglet' rel='stylesheet' type='text/css'>
	<link href='http://fonts.googleapis.com/css?family=Ropa+Sans' rel='stylesheet'>
	<link href="http://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet" type="text/css">
	<link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">

	<!-- Bootstrap core CSS -->
	<link href="${resource(dir: 'assets/css', file: 'bootstrap.css')}" rel="stylesheet">
	<link href="${resource(dir: 'assets/css', file: 'grayscale.css')}" rel="stylesheet">
	<link href="${resource(dir: 'assets/css', file: 'icomoon.css')}"  rel="stylesheet">

</head>

<body data-spy="scroll" data-offset="0" data-target=".navbar-fixed-top">

	<nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand page-scroll navbar-custom-white" href="#page-top">
					<span class="icon-puzzle-2 light navbar-custom-white"></span>REMAR
				</a>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse navbar-right navbar-main-collapse">
				<ul class="nav navbar-nav">
					<!-- Hidden li included to remove active class from about link when scrolled up past about section -->
					<li class="hidden">
						<a href="#page-top"></a>
					</li>
					<li>
						<a class="page-scroll" href="#groupRemar">GT-REMAR</a>
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

					<li id="navbar-custom-green">
					</li>
				</ul>
				<g:link  class="btn btn-default btn-login" controller="login">Entrar</g:link>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</nav>


	<!-- Intro Header -->
	<header class="intro">
		<section id="page-top" class="content-section text-center" >
			<div class="intro-body">
				<div class="container">
					<div class="row">
						<div class="col-md-8 col-md-offset-2">
							<h1 class="brand-heading">REMAR</h1>
							<p class="intro-text">Recursos Educacionais Multiplataforma Abertos na Rede </p>
							<a href="#groupRemar" class="btn btn-circle page-scroll">
								<span class="icon-circle-arrow-down"></span>
							</a>
						</div>
					</div>
				</div>
			</div>
		</section>
	</header>

    <div class="container-black">
        <section class="content-section text-center">
            <div class="about-section">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8 col-lg-offset-2 about">
                            <div class="container-black">
                                %{--GroupRemar--}%
                                <div id="groupRemar"  class="about-section">
                                    <div class="container-custom">
                                        <h2 style="text-align: left;">GT-REMAR</h2>
                                        <p style="text-align: justify">
                                    Este projeto encontra-se no contexto dos grupos de trabalho (GTs) Temáticos em EAD (sub-tema: Universidade Aberta OnLine) da RNP.
                                    O GT-REMAR tem como objetivo facilitar e ampliar a construção e o reuso de recursos educacionais abertos (REA), por meio de um serviço,
                                    na forma de uma plataforma web, que ofereça ferramentas que facilitem a construção e a customização de REA, seguindo diretrizes que favoreçam
                                    o reuso, a disponibilização desses recursos em diferentes plataformas, bem como a integração com ambientes virtuais de aprendizagem. Espera-se obter
                                    como resultados: (i) um conjunto de diretrizes para o desenvolvimento de REA reutilizáveis, adaptáveis, multiplataforma e acessíveis; (ii) um protótipo
                                    da plataforma, que deverá ser testado e validado por meio do desenvolvimento e adaptação de REA pelo grupo proponente, em conjunto com instituições parceiras.
                                </p>
                                    </div>
                                </div>
                                %{--Fim GroupRemar--}%

                                %{--Descrição--}%
                                <div id="description"  class="about-section">
                                    <div class="container-custom">
                                        <h2 style="text-align: left;">Descrição</h2>
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
                                %{--Fim Descrição--}%

                                %{--Arquitetura--}%
                                <div id="architecture"  class="about-section">
                                    <div class="container-custom">
                                        <h2  style="text-align:left;">Arquitetura</h2>
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
                                            <img src="../images/architecture.png" width="90%" height="90%"></img>
                                        </div>
                                    </div>
                                </div>
                                %{--Fim Arquitetura--}%

                                %{--Equipe--}%
                                <div id="team"  class="about-section">
                                    <div class="container-custom">
                                        <h2 style="text-align:left;">Equipe</h2>
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
                                    </div>
                                </div>
                                %{--Fim Equipe--}%

                                %{--Parceiros--}%
                                <div id="partners"  class="about-section">
                                    <div class="container-custom">
                                        <h2 style="text-align:left;">Parceiros</h2>
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
                                            <div>
                                                <a href="http://www.rnp.br/" target="_blank" rel="prettyPhoto" title="Rede Nacional de Ensino e Pesquisa">
                                                    <img src="../images/partners/rnp.png" alt="RNP">
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                %{--Fim Parceiros--}%

                                %{--Contato--}%
                                <div id="contact"  class="about-section">
                                    <div class="container-custom">
                                        <h2 style="text-align:left;">Contato</h2>
                                        <p style="text-align: justify">
                                            Email: remar@sead.ufscar.br
                                        </p>
                                        <p style="text-align: justify">
                                            Endereço: Universidade Federal de São Carlos, At3 - Sala 54 - São Carlos - SP
                                        </p>
                                    </div>
                                </div>
                                %{--Fim Contato--}%
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<!-- Map Section -->
	<div id="map"></div>

	<!-- Footer -->
	<footer>
		<div class="container text-center">
			<p>Copyright &copy; Your Website 2014</p>
		</div>
	</footer>
</div>

	<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'jquery.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'bootstrap.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'jquery.easing.1.3.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'grayscale.js')}"></script>

	%{--<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'modernizr.custom.js')}"></script>--}%
	%{--<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'retina.js')}"></script>--}%
	%{--<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'smoothscroll.js')}"></script>--}%
	%{--<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'jquery-func.js')}"></script>--}%

</body>
</html>

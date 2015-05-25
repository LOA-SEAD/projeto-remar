======================================================================================================
Instalando o moodle
======================================================================================================

- Baixar o moodle (versão 2.8.5 ou maior)
- Descompactar em sua pasta www (ou onde estiver rodando seu Apache)
- Criar o usuário admin
- Setar as configurações do moodle (como acessar o moodle)
- Criar um novo Curso:
	Administração >> Administração do site >> Cursos >> Gerenciar Cursos e Categorias


======================================================================================================
Instalar o plugin REMAR
======================================================================================================

- Entrar na pasta Moodle do REMAR
- Gerar o arquivo ZIP da pasta (sugestão: nome do arquivo remar.zip
- Acesse a página:
	Administração >> Administraçã odo site >> Plugins >> Instalar plugins
- Faça o upload do arquivo .zip
- Clique em instalar
- Atualizar a database do moodle com a database do plugin clicando em  "Upgrade Moodle database now"
- Aparecerá uma tela com as configurações do plugin (não precisa mudar nada, são apenas campos testes)


======================================================================================================
Configurando o Moodle para aceitar o REMAR
======================================================================================================

- Habilitar os serviços de web (web services)
	Administração >> Administração do site >> Opções Avançadas >> Habilitar serviços web
- Adicionar permissão para serviço do remar
	Administração >> Administração do site >> Plugins >> Serviços da Web >> Serviços externos
	Crie um novo serviço personalizado
	Clique em "Funções" deste novo serviço e "Adicionar Funções"
	Adicione a função "mod_remar_quiforca_update"
- Ativar o protocolo XML-RPC
	Administração >> Administração do site >> Plugins >> Serviços da Web >> Gerenciar protocolos
- Autorizar usuário a usar o protocolo XML-RPC
	Administração >> Administração do site >> Permissões >> Verificar permissões do sistema
- Criar um papel para os usuários que terão acesso
	Administração >> Administração do site >> Usuários >> Permissões >> Definir papéis
	Crie um novo papel remar com base no papel ou arquétipo "Estudante"
	Habilite a opção "Use o protocolo XML-RPC" (webservice/xmlrpc:use)
- Atribua este papel ao usuário que irá usar o remar
- Criar um token para o usuário (cliente) acessar o moodle externamente
	Administração >> Administração do site >> Plugins >> Gerenciar tokens
	Adicione um novo toke escolhendo o usuário e o webservice criado no em 2 passos anteriores


======================================================================================================
Usando o REMAR
======================================================================================================

- Entre na página do curso que deseja usar
- Clique no botão "Habilitar Edição"
- Clique em "Adicionar Atividade ou Recurso"
- Selecione qual jogo do remar você deseja adicionar
- Faça as configurações que desejar




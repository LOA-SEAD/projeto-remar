<%@ page import="br.ufscar.sead.loa.remar.User" %>

<h3>Prezado(a) ${user.firstName} ${user.lastName}, bem-vindo ao REMAR!</h3>
<br/>
<p>Você foi cadastrado pelo administrador da plataforma com as seguintes credenciais:</p>
<br/>
<p><strong>Nome de usuário:</strong> ${user.username}</p>
<p><strong>Senha:</strong> ${user.password}</p>
<br/>
<p>Clique <a href="http://${request.serverName}">aqui</a> para acessar o REMAR ou <a href="http://${request.serverName}/my-profile">aqui</a> se deseja mudar sua senha.</p>
<br/>
<p>Atenciosamente,</p>
<p>Equipe REMAR</p>
<p>Recursos Educacionais Multiplataforma Abertos na Rede</p>
<br/>
<br/>
<br/>
<p>**********************************************************************</p>
<p>Este é um e-mail automático. Não é necessário respondê-lo.</p>
<p>Caso tenha recebido esta mensagem por engano, por favor, apague-a.</p>
<p>Agradecemos sua cooperação.</p>
<p>**********************************************************************</p>

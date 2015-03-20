import projetoremar.Usuario
import projetoremar.Papel
import projetoremar.UsuarioPapel
import projetoremar.Professor

class BootStrap {

    def init = { servletContext ->

	def adminPapel = Papel.findByAuthority("ROLE_ADMIN") ?: new Papel(authority: "ROLE_ADMIN").save()

	def admin = new Usuario(
		username: "admin",
		password: "admin",
		nome: "Administrador",
		enabled: true)

	admin.save()

	if(admin.hasErrors()){
		println admin.errors
	}

	UsuarioPapel.create(admin, adminPapel)

	print 'populando usuário admin - ok'

	def profPapel = Papel.findByAuthority("ROLE_PROF") ?: new Papel(authority: "ROLE_PROF").save()

	def professor = new Professor(
		nome: "delano",
		username: "prof",
		password: "prof",
		enabled: true)

	professor.save()

	if(professor.hasErrors()){
		println professor.errors
	}

	UsuarioPapel.create(professor, profPapel)

	print 'populando professor - ok'

	def alunoPapel = Papel.findByAuthority("ROLE_ALUNO") ?: new Papel(authority: "ROLE_ALUNO").save()

	def aluno = new Usuario(
		username: "aluno",
		password: "aluno",
		nome: "Aluno",
		enabled: true)

	aluno.save()

	if(aluno.hasErrors()){
		println aluno.errors
	}

	UsuarioPapel.create(aluno, alunoPapel)

	print 'populando aluno - ok'

    }
    def destroy = {
    }
}

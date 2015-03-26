import projetoremar.Usuario
import projetoremar.Papel
import projetoremar.UsuarioPapel
import projetoremar.Professor

class BootStrap {

    def init = { servletContext ->

	def adminPapel = new Papel(authority: "ROLE_ADMIN").save flush: true

	def admin = new Usuario(
		username: "admin",
		password: "admin",
		name: "Administrador",
		enabled: true).save flush: true

	if(admin.hasErrors()){
		println admin.errors
	}

	UsuarioPapel.create(admin, adminPapel, true)

	print 'populando usuário admin - ok'

	def profPapel = new Papel(authority: "ROLE_PROF").save flush: true

	def professor = new Professor(
		name: "Cleyton",
		username: "prof",
		password: "prof",
		enabled: true).save flush: true

	if(professor.hasErrors()){
		println professor.errors
	}

	UsuarioPapel.create(professor, profPapel, true)

	print 'populando professor - ok'

	def alunoPapel = new Papel(authority: "ROLE_ALUNO").save flush: true

	def aluno = new Usuario(
		username: "aluno",
		password: "aluno",
		name: "Aluno",
		enabled: true).save flush: true

	if(aluno.hasErrors()){
		println aluno.errors
	}

	UsuarioPapel.create(aluno, alunoPapel, true)

	print 'populando aluno - ok'

    }
    def destroy = {
    }
}

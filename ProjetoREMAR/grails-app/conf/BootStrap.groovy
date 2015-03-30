import projetoremar.Palavras
import projetoremar.Usuario
import projetoremar.Papel
import projetoremar.UsuarioPapel
import projetoremar.Professor

import javax.servlet.http.HttpServletRequest

class BootStrap {

    def init = { servletContext ->

        HttpServletRequest.metaClass.isXhr = {->
            'XMLHttpRequest' == delegate.getHeader('X-Requested-With')
        }

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

        new Palavras(dica: "dica1", resposta: "resposta1", contribuicao: "Cleyton").save flush: true
        new Palavras(dica: "dica2", resposta: "resposta2", contribuicao: "Cleyton").save flush: true
        new Palavras(dica: "dica3", resposta: "resposta3", contribuicao: "Cleyton").save flush: true

    }
    def destroy = {
    }
}

import br.ufscar.sead.loa.quiforca.remar.Question
import br.ufscar.sead.loa.remar.Administrator
import br.ufscar.sead.loa.remar.Professor
import br.ufscar.sead.loa.remar.Role
import br.ufscar.sead.loa.remar.Student
import br.ufscar.sead.loa.remar.UserRole
import grails.plugin.springsecurity.SecurityConfigType



import javax.servlet.http.HttpServletRequest

class BootStrap {

    def init = { servletContext ->

        HttpServletRequest.metaClass.isXhr = {->
            'XMLHttpRequest' == delegate.getHeader('X-Requested-With')
        }

        def admin = new Administrator(
                username: "admin",
                password: "admin",
                firstName: "Cleyton",
                lastName: "Junior",
                enabled: true).save flush: true

        def professor = new Professor(
                firstName: "Cleyson",
                lastName: "Silva",
                username: "prof",
                password: "prof",
                enabled: true).save flush: true

        def student = new Student(
                username: "stud",
                password: "stud",
                firstName: "Cleiton",
                lastName: "Souza",
                enabled: true).save flush: true

        if(admin.hasErrors()){
            println admin.errors
        }

        if(professor.hasErrors()){
            println professor.errors
        }

        if(student.hasErrors()){
            println student.errors
        }

        def adminRole = new Role(authority: "ROLE_ADMIN").save flush: true
        def professorRole = new Role(authority: "ROLE_PROF").save flush: true
        def studentRole = new Role(authority: "ROLE_STUD").save flush: true

        UserRole.create(admin, adminRole, true)
        UserRole.create(admin, professorRole, true)
        UserRole.create(admin, studentRole, true)
        UserRole.create(professor, professorRole, true)
        UserRole.create(student, studentRole, true)


//        def springContext = WebApplicationContextUtils.getWebApplicationContext(servletContext)
//        springContext.getBean('marshallers').register();


        // *************************

        new Question(statement: "Q1", answer: "A1", category: "C1", ownerId: professor.getId(), author: professor.getFirstName()).save flush: true
        new Question(statement: "Q2", answer: "A2", category: "C1", ownerId: professor.getId(), author: professor.getFirstName()).save flush: true
        new Question(statement: "Q3", answer: "A3", category: "C2", ownerId: admin.getId(), author: admin.getFirstName()).save flush: true
        new Question(statement: "Q4", answer: "A4", category: "C3", ownerId: professor.getId(), author: professor.getFirstName()).save flush: true
        new Question(statement: "Q5", answer: "A5", category: "C4", ownerId: admin.getId(), author: admin.getFirstName()).save flush: true
        new Question(statement: "Q6", answer: "A6", category: "C3", ownerId: professor.getId(), author: professor.getFirstName()).save flush: true
        new Question(statement: "Q7", answer: "A7", category: "C4", ownerId: admin.getId(), author: admin.getFirstName()).save flush: true

//        new Reque

        println "Bootstrap: done"

    }
    def destroy = {
    }
}

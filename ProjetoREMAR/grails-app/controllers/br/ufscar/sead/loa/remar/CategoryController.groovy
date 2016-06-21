package br.ufscar.sead.loa.remar



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.converters.JSON

class CategoryController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        respond Category.list(), model:[categoryCount: Category.count()]
    }

    def show(Category category) {
        respond category
    }

    def create() {
        respond new Category(params)
    }

    @Transactional
    def save() {
        Category category = new Category(params)

        if (category == null) {
            notFound()
            return
        }

        if (category.hasErrors()) {
            respond category.errors, view:'create'
            return
        }

        category.save flush:true
//
//        request.withFormat {
//            form multipartForm {
//                flash.message = message(code: 'default.created.message', args: [message(code: 'category.label', default: 'Category'), category.id])
//                redirect category
//            }
//            '*' { respond category, [status: CREATED] }
//        }

       render category as JSON
    }

    def edit(Category category) {
        respond category
    }

    @Transactional
    def update(Category category) {

        log.debug(category.name)


        if (category == null) {
            notFound()
            return
        }

        if (category.hasErrors()) {
            respond category.errors, view:'edit'
            return
        }

        category.save flush:true

        render true
    }

    @Transactional
    def delete(Category category) {
        log.debug("entrou aki!")
        println(category);
        print(params);

        if (category == null) {
            notFound()
            return
        }

        category.delete flush:true

        render true
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'category.label', default: 'Category'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}

package br.ufscar.sead.loa.remar

/**
 * Created by lucas on 25/07/16.
 */
import  grails.validation.Validateable

import java.lang.annotation.Annotation

class MetadataForm implements Validateable {

    String author
    String editor
    String title
    String description
    Date   publication_date
    String license

    static constraints = {
        author(nullable: false, blank: false)
        editor (nullable: false, blank: false)
        title (nullable: false, blank: false)
        description (nullable: false, blank: false)
        publication_date (nullable: false, blank: false)
        license (nullable: false, blank: false, inList: ["cc-by-sa", "cc-by-nc-sa"])
    }

    @Override
    boolean nullable() {
        return false
    }
    @Override
    Class<? extends Annotation> annotationType() {
        return null
    }

    @Override
    String toString() {

        return "${author}\n${editor}\n${title}\n${description}\n${publication_date.toString()}\n${license}"
    }
}

package br.ufscar.sead.loa.remar

/**
 * Created by lucas on 25/07/16.
 */

class MetadataForm {

    String author
    String citation
    String title
    String description
    String publication_date
    String license

    ArrayList<String> bitstreams

    MetadataForm(){}

    MetadataForm(String author, String citation, String title,
                 String description, String publication_date, String license,
                 ArrayList<String> bitstreams) {

        this.author = author
        this.citation = citation
        this.title = title
        this.description = description
        this.publication_date = publication_date
        this.license = license
        this.bitstreams = new ArrayList<>()
    }


    @Override
    String toString() {
        return "${author}\n${editor}\n${citation}\n${title}\n${description}\n${publication_date}\n${license}"
    }
}

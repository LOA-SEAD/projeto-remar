package br.ufscar.sead.loa.remar

class Announcement {
    String title
    String body
    Date dateCreated
    User author

    static belongsTo = [author: User]
    static constraints = {
    	title blank: false
        body blank: false
    }
}

package br.ufscar.sead.loa.remar

class Announcement {
    String title
    String body
    User author
    String type

    static belongsTo = [author: User]
    static constraints = {
    	title blank: false
    	type inList: ["Simples", "Imagem", "Widget"]
    }



    static def getMainAnnouncements() {

    }
}

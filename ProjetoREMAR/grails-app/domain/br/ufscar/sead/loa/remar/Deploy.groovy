package br.ufscar.sead.loa.remar

class Deploy {
    User owner

    static constraints = {
        submittedAt blank: false
        name blank: false
        comment nullable: true, blank: true
    }

    Date submittedAt
    String status
    String name
    String comment
    String uri
    boolean valid


}

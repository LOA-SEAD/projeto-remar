package br.ufscar.sead.loa.remar

class Report {

    static constraints = {
        url blank: false
        description blank: false
        type inList: ["comment", "bug", "abuse"]
    }

    User    who                 // who found it?
    Date    date                // when did it happen?
    String  url                 // where did it happen?
    String  description         // the description given by the user
    String  type                // comment, bug or abuse?
    String  browser             // what browser was the user using
    Boolean seen                // has it already been seen by the admin?
    Boolean screenshot          // does it have any screenshots related?
}

package br.ufscar.sead.loa.remar

class Category {

    static constraints = {
        name blank: false
        description nullable: true, maxSize: 1000
    }

    String name
    String description

    String toString(){
        return name + " "+ description
    }
}
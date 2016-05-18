package br.ufscar.sead.loa.remar

/**
 * Created by deniscapp on 5/17/16.
 */
class Group {

    String name;
    String owner;

    static mapping = {
        table "group_"
    }

    static constraints = {
        name blank: false
        owner blank: false
    }
}

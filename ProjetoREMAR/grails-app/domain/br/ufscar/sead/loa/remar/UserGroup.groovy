package br.ufscar.sead.loa.remar

class UserGroup {

    static belongsTo = [user:User,group:Group]
    boolean admin

    UserGroup(){
        this.admin = false
    }

    static constraints = {
    }

    static void removeAllByGroup(Group g, boolean flush = false) {
        if (g == null) return

        UserGroup.where {
            group == Group.load(g.id)
        }.deleteAll()

        if (flush) {
            UserGroup.withSession { it.flush() }
        }
    }

    static void removeAllByUser(User u, boolean flush = false) {
        if (u == null) return

        UserGroup.where {
            user == User.load(u.id)
        }.deleteAll()

        if (flush) {
            UserGroup.withSession { it.flush() }
        }
    }
}

package br.ufscar.sead.loa.remar

class GroupExportedResources {

    static belongsTo = [group: Group, exportedResource: ExportedResource]

    static constraints = {
    }

    static void removeAllByGroup(Group g, boolean flush = false) {
        if (g == null) return

        GroupExportedResources.where {
            group == Group.load(g.id)
        }.deleteAll()

        if (flush) {
            GroupExportedResources.withSession { it.flush() }
        }
    }
}

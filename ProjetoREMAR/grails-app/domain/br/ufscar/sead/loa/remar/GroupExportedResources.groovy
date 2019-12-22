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

    static void removeAllByExportedResource(ExportedResource er, boolean flush = false) {
        if (er == null) return

        GroupExportedResources.where {
            exportedResource == ExportedResource.load(er.id)
        }.deleteAll()

        if (flush) {
            GroupExportedResources.withSession { it.flush() }
        }
    }
}

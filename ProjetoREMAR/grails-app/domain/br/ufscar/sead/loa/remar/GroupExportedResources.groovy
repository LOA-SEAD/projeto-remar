package br.ufscar.sead.loa.remar

class GroupExportedResources {

    static belongsTo = [group: Group, exportedResource: ExportedResource]

    static constraints = {
    }
}

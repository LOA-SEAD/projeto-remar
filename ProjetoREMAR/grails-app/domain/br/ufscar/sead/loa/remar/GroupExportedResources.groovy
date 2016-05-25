package br.ufscar.sead.loa.remar

class GroupExportedResources {

    static belongsTo = [group: Group, exportedResources: ExportedResource]

    static constraints = {
    }
}

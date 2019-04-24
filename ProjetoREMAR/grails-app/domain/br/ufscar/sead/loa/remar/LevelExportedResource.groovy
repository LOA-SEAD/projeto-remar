package br.ufscar.sead.loa.remar

class LevelExportedResource {

    static constraints = {
        level nullable: false
        exportedResource nullable: false
    }

    Level level
    ExportedResource exportedResource
}

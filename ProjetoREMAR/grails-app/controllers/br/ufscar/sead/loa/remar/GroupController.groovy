package br.ufscar.sead.loa.remar


class GroupController {

    def list() {
        def groups = Group.findAll()

        render(view: "list", model: [groups: groups])
    }
}

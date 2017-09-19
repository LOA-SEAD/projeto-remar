package br.ufscar.sead.loa.remar.statistics

class DragPictures extends Statistics{

    Object getData(params){

        def data = super.getData(params)

        data.numberDrag = params.numberDrag
        data.initialSequence = params.initialSequence

        return data
    }

}
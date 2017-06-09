/*
 * Autor: Pedro Garcia
 *
 *
 * O objetivo dessa classe é monitorar o processo de exportação de um jogo
 * para diferentes plataformas, facilitando o feedback para o usuário
 * em uma view.
 */

package br.ufscar.sead.loa.remar

import groovy.transform.Synchronized

class ResourceExportMonitor {
    /*
     * Flags representando o estado de cada plataforma.
     * False/0: undone, True/1: done
     */
    def flags = [:]

    ResourceExportMonitor () { }

    ResourceExportMonitor (platformList) {
        for (platform in platformList)
            flags[platform] = false
    }

    void setFlag(String platform, Boolean isDone) {
        flags[platform] = isDone
    }

    void setFlag(String platform, int isDone) {
        if (isDone != 0 || isDone != 1)
            log.debug "ResourceExportMonitor.setFlag(): Invalid Flag Value [" + isDone + "]"
        else
            flags[platform] = isDone
    }
}

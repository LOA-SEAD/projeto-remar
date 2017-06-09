/*
 * Autor: Pedro Garcia
 *
 *
 * O objetivo dessa classe é implementar um conjunto de monitores
 * que agrupa todos os monitores de exportação que estão ativos
 * ao mesmo tempo.
 */

package br.ufscar.sead.loa.remar

import groovy.transform.Synchronized

public class MonitorClusterSingleton {

    private static final MonitorClusterSingleton instance = new MonitorClusterSingleton()
    def cluster = [:]

    /* Construtor ẽ privado, desta forma ninguém pode criar um cluster */
    private MonitorClusterSingleton() { }

    /* Getter da instância do cluster, desta forma todos usam o mesmo cluster */
    public static getInstance() {
        return instance
    }

    /* Funções de adição e remoção de monitores sincronizadas */
    @Synchronized
    ResourceExportMonitor getResourceExportMonitor (String id) {
        return cluster[id]
    }

    @Synchronized
    ResourceExportMonitor getResourceExportMonitor (Long id) {
        def exportedResourceId = String.valueOf(id)
        return cluster[exportedResourceId]
    }

    @Synchronized
    void setResourceExportMonitor (String id, ResourceExportMonitor monitor) {
        cluster[exportedResourceId] = monitor
    }

    @Synchronized
    void setResourceExportMonitor (Long id, ResourceExportMonitor monitor) {
        def exportedResourceId = String.valueOf(id)
        cluster[exportedResourceId] = monitor
    }

    @Synchronized
    Boolean removeResourceExportMonitor (String id) {
        try {
            cluster.remove(id)
            return true
        } catch (all) {
            return false
        }
    }

    @Synchronized
    Boolean removeResourceExportMonitor (Long id) {
        def exportedResourceId = String.valueOf(id)
        try {
            cluster.remove(exportedResourceId)
            return true
        } catch (all) {
            return false
        }
    }
}

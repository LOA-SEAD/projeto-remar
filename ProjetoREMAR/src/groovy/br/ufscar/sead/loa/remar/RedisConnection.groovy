package br.ufscar.sead.loa.remar

import grails.plugin.redis.RedisService

/**
 * Created by matheus on 6/3/15.
 */
class RedisConnection {
    private static RedisConnection instance;
    private RedisListener listener;
    private Thread thread;
    private def redisService

    private RedisConnection(rS, rL) {
        this.redisService = rS
        this.redisService.foo = "bar"
        this.listener = rL;
        this.thread = new Thread() {
            public void run() {
                redisService.subscribe(listener, "")
            }
        }
        this.thread.start()
    }

    public static RedisConnection getInstance(RedisService rS, RedisListener rL) {
        if (instance == null) {
            instance = new RedisConnection(rS, rL);
        }

        return instance;
    }

    public void pSubscribe(String pattern) {
        listener.psubscribe(pattern);
    }

    public void subscribe(String channel) {
        listener.subscribe(channel);
    }

    @Deprecated
    public void kill() {
        this.thread.interrupt()
    }

    @Deprecated
    public static void reset() {
        instance = null;
    }

}
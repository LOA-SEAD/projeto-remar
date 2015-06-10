package br.ufscar.sead.loa.remar

import redis.clients.jedis.JedisPubSub

/**
 * Created by matheus on 6/3/15.
 */
class RedisListener extends JedisPubSub {
    @Override
    void onMessage(String channel, String message) {
        println "message @ " + channel + ": " + message
    }

    @Override
    void onPMessage(String pattern, String channel, String message) {
        println "pmessage @ " + channel + ": " + message
    }

    @Override
    void onSubscribe(String channel, int i) {
        println "subscribe: " + channel

    }

    @Override
    void onUnsubscribe(String s, int i) {

    }

    @Override
    void onPUnsubscribe(String s, int i) {

    }

    @Override
    void onPSubscribe(String channel, int i) {
        println "pattern subscribe: " + channel

    }
}

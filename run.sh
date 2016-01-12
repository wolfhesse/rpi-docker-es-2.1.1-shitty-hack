#!/bin/bash

function set_es_config {
    echo "$1: $2" >> $ES_CONFIG_PATH
}

if [ ! -f $ES_CONFIG_PATH ]; then
    echo "Config file does not exist. Configuring elasticsearch."

    mkdir -p /data/logs
    mkdir -p /data/data
    cp -r /opt/elasticsearch/config/ /data/
    
    set_es_config "path.conf" "/data/config"
    set_es_config "path.data" "/data/data"
    set_es_config "path.logs" "/data/logs"
    set_es_config "script.disable_dynamic" "true" 
    
    set_es_config "cluster.name" $ES_CLUSTER_NAME

    if [ -n "$ES_NODE_NAME" ]; then
        set_es_config "node.name" $ES_NODE_NAME 
    fi

    set_es_config "node.master" $ES_NODE_MASTER
    set_es_config "node.data" $ES_NODE_DATA

    if [ -n "$ES_UNICAST_HOSTS" ]; then
        set_es_config "discovery.zen.ping.multicast.enabled" "false"
        set_es_config "discovery.zen.ping.unicast.hosts" $ES_UNICAST_HOSTS
    fi

    if [ -n "$ES_NETWORK_PUBLISH_HOST" ]; then
        set_es_config "network.publish_host" $ES_NETWORK_PUBLISH_HOST
    fi

    if [ -n "$ES_TRANSPORT_TCP_PORT" ]; then
        set_es_config "transport.tcp.port" $ES_TRANSPORT_TCP_PORT
    fi
fi

# und zurueckkopieren..
cp /data/config/elasticsearch.yml /opt/elasticsearch/config/

#exec /opt/elasticsearch/bin/elasticsearch -Des.config=$ES_CONFIG_PATH

#nochmal cand:del
chown -R elasticsearch /opt/elasticsearch
chown -R elasticsearch /data
#exec sudo -u elasticsearch /opt/elasticsearch/bin/elasticsearch
/opt/elasticsearch/bin/elasticsearch


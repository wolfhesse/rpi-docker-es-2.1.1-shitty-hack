#
# jpodeszwik/elasticsearch Dockerfile
#
FROM rpidockers/java:1.8.0_60

# Install elasticsearch
ENV ES_CONFIG_PATH /data/config/elasticsearch.yml 
ENV ES_VERSION 2.1.1
RUN \
  cd /tmp && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-$ES_VERSION.tar.gz && \
  tar xvzf elasticsearch-$ES_VERSION.tar.gz && \
  rm -f elasticsearch-$ES_VERSION.tar.gz && \
  mv /tmp/elasticsearch-$ES_VERSION /opt/elasticsearch-$ES_VERSION && \
  ln -s /opt/elasticsearch-$ES_VERSION /opt/elasticsearch

RUN mkdir /opt/elasticsearch/plugins

RUN useradd -ms /bin/bash elasticsearch
RUN chown -R elasticsearch /opt/elasticsearch-$ES_VERSION
RUN chown -R elasticsearch /opt/elasticsearch

# holy fuck https://github.com/elastic/elasticsearch/issues/14458#issuecomment-162336291
RUN set -x \
	&& apt-get update \
	&& apt-get install -y sudo

### # Install plugins
### RUN \
  ### cd /opt/elasticsearch/bin && \
  ### ./plugin --install royrusso/elasticsearch-HQ && \
  ### ./plugin --install mobz/elasticsearch-head && \
  ### ./plugin --install karmi/elasticsearch-paramedic && \
  ### ./plugin --install lukas-vlcek/bigdesk && \
  ### ./plugin --install jettro/elasticsearch-gui && \
  ### ./plugin --install lmenezes/elasticsearch-kopf

VOLUME ["/data"]

WORKDIR /data

ADD run.sh /bin/run.sh

USER elasticsearch
# Basic configuration
ENV ES_CLUSTER_NAME elasticwolf
ENV ES_NODE_MASTER true
ENV ES_NODE_DATA true  

ENV JAVA_HOME /opt/jdk
CMD /bin/run.sh


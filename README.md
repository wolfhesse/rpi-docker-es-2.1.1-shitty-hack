# rpidockers/elasticsearch
Image was tested on my ODROID-U3. It should also work on Raspberry Pi, but if not, you'll have to build it yourself.

```
$ git clone https://github.com/rpidockers/elasticsearch.git
$ docker build -t rpidockers/elasticsearch elasticsearch
```

## Tags
[1.7.1](https://github.com/rpidockers/elasticsearch/blob/1.7.1/Dockerfile)

[latest](https://github.com/rpidockers/elasticsearch/blob/master/Dockerfile)

## How to use this image
```
$ docker run -d -e ES_NETWORK_PUBLISH_HOST=<public_ip> -p 9200:9200 -p 9300:9300 -v <local_data_dir>:/data rpidockers/elasticsearch
```

example:
```
docker run -d -e ES_NETWORK_PUBLISH_HOST=192.168.1.1 -p 9200:9200 -p 9300:9300 -v /elasticsearch:/data rpidockers/elasticsearch
```

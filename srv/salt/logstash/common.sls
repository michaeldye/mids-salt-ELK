/etc/ssl/logstash-forwarder.key:
  file.managed:
    - user: logstash
    - group: logstash
    - mode: 644
    - contents_pillar: sslkeys:logstash-forwarder-key

/etc/ssl/logstash-forwarder.crt:
  file.managed:
    - user: logstash
    - group: logstash
    - mode: 644
    - source: salt://logstash/logstash-forwarder.crt

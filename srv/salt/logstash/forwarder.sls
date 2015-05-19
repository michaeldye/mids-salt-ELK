include:
  - logstash.common

logstash-forwarder-repo:
  pkgrepo.managed:
    - humanname: logstash forwarder repository
    - baseurl: http://packages.elasticsearch.org/logstashforwarder/centos
    - gpgcheck: 1
    - gpgkey: http://packages.elasticsearch.org/GPG-KEY-elasticsearch

logstash-forwarder:
  pkg.installed:
    - fromrepo: logstash-forwarder-repo

logstash-forwarder.service:
  service.running:
    - name: logstash-forwarder
    - enable: True
    - reload: True
    - require:
        - pkg: logstash-forwarder

/etc/logstash/conf.d/10-syslog.conf:
  file.managed:
    - user: logstash
    - group: logstash
    - mode: 644
    - source: salt://logstash/10-syslog.conf

/etc/logstash/conf.d/30-lumberjack-output.conf:
  file.managed:
    - user: logstash
    - group: logstash
    - mode: 644
    - source: salt://logstash/30-lumberjack-output.conf

/etc/logstash-forwarder.conf:
  file.managed:
    - user: logstash
    - group: logstash
    - mode: 644
    - source: salt://logstash/logstash-forwarder.conf


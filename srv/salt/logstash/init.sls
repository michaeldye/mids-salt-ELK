logstash-repo:
  pkgrepo.managed:
    - humanname: logstash repository for 1.5.x packages
    - baseurl: http://packages.elasticsearch.org/logstash/1.5/centos
    - gpgcheck: 1
    - gpgkey: http://packages.elasticsearch.org/GPG-KEY-elasticsearch

/etc/hosts:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://logstash/hosts

logstash:
  pkg.installed:
    - fromrepo: logstash-repo

/etc/logstash:
  file.directory:
    - user: logstash
    - group: logstash
    - mode: 755
    - recurse:
      - user
      - group
      - mode
    - requires:
      pkg: logstash

/etc/logstash/conf.d/01-lumberjack-input.conf:
  file.managed:
    - user: logstash
    - group: logstash
    - mode: 644
    - source: salt://logstash/01-lumberjack-input.conf

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

logstash.service:
  service.running:
    - name: logstash
    - enable: True
    - reload: True

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

/etc/logstash-forwarder.conf:
  file.managed:
    - user: logstash
    - group: logstash
    - mode: 644
    - source: salt://logstash/logstash-forwarder.conf

logstash-forwarder.service:
  service.running:
    - name: logstash-forwarder
    - enable: True
    - reload: True

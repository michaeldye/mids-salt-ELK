include:
  - common

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

# salt-elk

## Introduction

Salt state and pillar data to set up a single-box ELK stack. To use this, you'll need to have a saltmaster (ask Mike if you need help with this).

You'll also need to generate an SSL certificate for the logstash forwarder and paste the content into `srv/pillar/ssl.sls` (be careful of YAML formatting in that file). Make sure to set the CN to 'elk.mids'. Copy the matching cert into `srv/salt/logstash/`.

Your openssl key and cert generation commands may look like this:

    openssl genrsa -out logstash-forwarder.key 4096

    openssl req -subj "/C=US/ST=State/L=City/O=Org/CN=elk.mids/emailAddress=you@yourpad.co" -new -key logstash-forwarder.key -out logstash-forwarder.csr

    openssl x509 -req -days 3650 -in logstash-forwarder.csr -signkey logstash-forwarder.key -out logstash-forwarder.crt

Note that logstash-forwarders are really picky about SSL certs; ensure that the CN of the certificate above matches at least the hostname of the system that will be hosting your logstash server.

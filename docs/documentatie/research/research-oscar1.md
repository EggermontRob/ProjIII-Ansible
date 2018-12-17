# Installeren van Elastic Stack

Om Elastic Stack te installeren moet je aan paar dingen installeren. De dingen die geïnstalleerd moeten worden zijn
- Elasticsearch
- Kibana
- Logstash
- Beats

## PreInstall
**Note** Elasticsearch heeft Java 8 nodig. 

## Instaleren van Elasticsearch

Dit installeren we met het volgende commando:
```
yum install deflaut-jre
```
Eerst zetten we elastic.co key op de server via volgend commando, dit geeft downloaden toegang tot de elastic-server.
```
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
```
*wget* zorgt er voor dat de volgende pakkets kunnen gedownload worden.
We downloaden en installeren het via volgende commando's
```
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.1.1.rpm
rpm -ivh elasticsearch-5.1.1.rpm
```
X-Pack zal automatisch index nummering toevoegen. Normaal zal Elasticsearch dit automatisch ook toestaan. zonder dat er stappen nodig zijn. Stel dat dit uitgeschakkelijk zou zijn, moet de *action.auto_create_index* geconfiugren worden. Deze vind men terug in het voorbestemende .yml bestand.

```
action.auto_create_index: .security,.monitoring*,.watches,.triggered_watches,.watcher-history*,.ml*
```

**Note** Als u Logstash of Beats gebruikt, moeten er extra indexnamen worden ingesteld in *action.auto_create_index-instelling* en de waarde is afhankelijk van uw lokale configuratie. Als u niet zeker bent van de juiste waarde voor uw omgeving, kunt u de waarde in te stellen op \*, waarmee u automatisch alle indexen kunt maken.

De optie *bootstrap.memory_lock* in het het bestand */etc/elasticsearch/*elasticsearch.yml* schakelt memory swapping voor Elasticsearch uit.
```
bootstrap.memory_lock: true
```

Verder in deze file zetten we de network.host en http.port lijnen uit commentaar
```
network.host: localhost
http.port: 9200
```
Ook kunnen er nog zaken worden aagepast in */usr/lib/systemd/system/elasticsearch.servicee* zoals *LimitMEMLOCK* we raden aan om deze infinity te zetten ( moest u dit niet willen kan u hier natuurlijk ook voor kiezen)
```
LimitMEMLOCK=infinity
```

Zorg er voor dat in */etc/sysconfig/elasticsearch* dit ook in geconfigureerd
```
MAX_LOCKED_MEMORY=unlimited
```

Na alle configuratie zal je de service moeten herhalen , dit gebuerd met de gekende commandos
```
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch
```

Nu kunnen we de elasticsearch starten.

```
./bin/elasticsearch
```

Om te testen of voeren of dit werkt gebruik je
```
GET /
```

Als alles goed is gegaan in het installatie proces krijg je deze output

```javascript
{
  "name" : "Cp8oag6",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "AT69_T_DTp-1qgIJlatQqA",
  "version" : {
    "number" : "6.4.2",
    "build_flavor" : "default",
    "build_type" : "zip",
    "build_hash" : "f27399d",
    "build_date" : "2016-03-30T09:51:41.449Z",
    "build_snapshot" : false,
    "lucene_version" : "7.4.0",
    "minimum_wire_compatibility_version" : "1.2.3",
    "minimum_index_compatibility_version" : "1.2.3"
  },
  "tagline" : "You Know, for Search"
}
```

Werkt dit niet , zorg er dan voor dat poort **9200** aan het luisteren is.
Controleer ook of alle memory instelling inorde staan
```
curl -XGET 'localhost:9200/_nodes?filter_path=**.mlockall&pretty'
curl -XGET 'localhost:9200/?pretty'
```
### Directory layout van elasticsearch packet's
```
Home
│   bin
│   conf   
│   data
│   logs
│   plugins
│   repo
│   script
```

**bin** Dit zal er voor zorgen dat elasticsearch wordt ge instaleerd en de elasticsearch-plugin's worden gestart.  
**conf** Hier zit de configuratie van elasticsearch en ook het elasticsearch.yml bestand waar *action.auto_create_index* kan declareert worden.  
**data** De locatie van de gegevensbestanden.
**logs** Hier komen alle log's die worden gemaakt.
**plugins** Hierkomen alle plugins, elke plug-in zal een submap hebben.
**repo** Gedeelde oplag met het hostsysteem.
**script** Hierin staan alle files.


# installeren van Kibana

Eerst de installatie van den zaken die nodig zijn voor Kibana
```
wget https://artifacts.elastic.co/downloads/kibana/kibana-5.1.1-x86_64.rpm
rpm -ivh kibana-5.1.1-x86_64.rpm
```

In */etc/kibana/kibana.yml* moeten er volgende zaken gewijzigd worden (dit zijn de netwerkzaken die uit commentaar moeten gehalend worden)
```
server.port: 5601
server.host: "localhost"
elasticsearch.url: "http://localhost:9200"
```
Na deze configuratie is het aangeraden om de services te herstarten
```
sudo systemctl enable kibana
sudo systemctl start kibana
```

Het starten van Kibana gebeurd met onderstaand commando
```
./bin/kibana
```

### Directory layout van kibana packets
```
Home
│   bin
│   config   
│   data
│   optimize
│   plugins
```

**bin** Dit zal er voor zorgen dat elasticsearch wordt ge instaleerdh en de elasticsearch-plugin's worden gestart.  
**config** Hier zit de configartie van kibana waaronder ook het kibana.yml bestand  
**data** Hierin schrijft kibana en de plugin's van kibana.
**optimize** Bepaalde beheeracties (bijvoorbeeld plugin-installatie)  
**plugins** Hier komen alle plugins, elke plug in zal een submap hebben.

## de instalatie van Nginx (niet nodig voor dit project)

De eerste stappen zijn het downloaden en instaleren van Nginx, net als httpd.
```
yum -y install epel-release
yum -y install nginx httpd-tools
```

In de */etc/nginx/* moet de *server { }'* block verwijderd worden. Op deze manier kunnen nieuwe virtual host's worden  toevoegd. Maak hierna een new file op path */etc/nginx/conf.d/kibana.conf* waar volgende configuratie inzet wordt. Hiermee hebben we een nieuwe virtual host gemaakt.
```
server {
    listen 80;
 
    server_name elk-stack.co;
 
    auth_basic "Restricted Access";
    auth_basic_user_file /etc/nginx/.kibana-user;
 
    location / {
        proxy_pass http://localhost:5601;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```
Het aanmaken van de basis authentication file:
```
sudo htpasswd -c /etc/nginx/.kibana-user admin
TYPE YOUR PASSWORD
```
Het starten van en enabalen van nginx
```
nginx -t
systemctl enable nginx
systemctl start nginx
```

Het starten van Kibana gebuerd met onderstaand commando
```
./bin/kibana
```

# instaleren van Logstash (niet nodig voor dit project)

Eerst gebeurd de installatie die nodig zijn om Logstash te laten werken.
```
wget https://artifacts.elastic.co/downloads/logstash/logstash-5.1.1.rpm
rpm -ivh logstash-5.1.1.rpm
```
Het is nodig om een ssl key te maken, dit doen we door naar het path */etc/pki/tls* te gaan en in de file *openssl.cnf* volgende configuratie aan te passen.
```
[ v3_ca ]

# Server IP Address
subjectAltName = IP: 0.0.0.0
```

Het maken van een nieuwe sll key aan gebuerd via het commando. Dit is te vinden op het path *'/etc/pki/tls/certs/'* en het path *'/etc/pki/tls/private/'* 
```
openssl req -config /etc/pki/tls/openssl.cnf -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout /etc/pki/tls/private/logstash-forwarder.key -out /etc/pki/tls/certs/logstash-forwarder.crt
```

In het bestand */etc/logstash/conf.d/filebeat-input.conf* vullen volgende configuratie toe
```
input {
  beats {
    port => 5443
    ssl => true
    ssl_certificate => "/etc/pki/tls/certs/logstash-forwarder.crt"
    ssl_key => "/etc/pki/tls/private/logstash-forwarder.key"
  }
}
```
in *conf.d/syslog-filter.conf* moet dit aangevuld worden.
```
filter {
  if [type] == "syslog" {
    grok {
      match => { "message" => "%{SYSLOGTIMESTAMP:syslog_timestamp} %{SYSLOGHOST:syslog_hostname} %{DATA:syslog_program}(?:\[%{POSINT:syslog_pid}\])?: %{GREEDYDATA:syslog_message}" }
      add_field => [ "received_at", "%{@timestamp}" ]
      add_field => [ "received_from", "%{host}" ]
    }
    date {
      match => [ "syslog_timestamp", "MMM  d HH:mm:ss", "MMM dd HH:mm:ss" ]
    }
  }
}
```

Maak je output file nog op het path *conf.d/output-elasticsearch.conf*
En hier komt deze confuratie in.
```
output {
  elasticsearch { hosts => ["localhost:9200"]
    hosts => "localhost:9200"
    manage_template => false
    index => "%{[@metadata][beat]}-%{+YYYY.MM.dd}"
    document_type => "%{[@metadata][type]}"
  }
  
}
```
De laaste stap in het starten en enablen van logstack, met de gekende commando's
```
sudo systemctl enable logstash
sudo systemctl start logstash
```

## Metricbeat
De installatie van Metricbeat gebeurd op dezelfde manier alle andere plugin's, via volgende commando's
```
yum install https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.4.2-x86_64.rpm
```
Alle configuratie kan worden aangepast in */etc/metricbeat/metricbeat.yml*  
Om modules toetevoegen aan metricbeat gebruik het commando
```
metricbeat modules enable <MODULE>
```

Het toevoegen van dashboard gebuerd via 
```
metricbeat setup --dashboards
```

**Note** Deze zal op elke hots worden geinstaleerd

## Packetbeat

De instalatie van Packetbeat gebeurd op dezelfde manier alle andere plugin's, via volgende commando's
```
yum install https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.4.2-x86_64.rpm
```
Alle configuratie kunt u aanpassen in */etc/packetbeat/packetbeat.yml*  
Om modules toetvoegen aan packetbeat gebruik je volgende commando
```
packetbeat modules enable <MODULE>
```

Het toevoegen van dashboard gebuerd via 
```
packetbeat setup --dashboards
```


# Bronnen
https://www.elastic.co/guide/en/elastic-stack/current/installing-elastic-stack.html?fbclid=IwAR3fd2wD7YJFcIaed7x_O-bwrv3IMJMTncUyCoZEhjFAU-wiNZMj2ietEUE  

https://www.howtoforge.com/tutorial/how-to-install-elastic-stack-on-centos-7/?fbclid=IwAR16bJ_mrLj0Eed45auMhJOEXPYCF5am_sTf-u7Pz86L3CTDCZRA4tH4Nf4  

https://www.elastic.co/guide/en/beats/packetbeat/current/packetbeat-installation.html  

https://www.elastic.co/guide/en/beats/metricbeat/current/index.html  

# testomgeving opzetten

Zorg er voor dat je in het domein zit ( via een fixed ip of via de dhcp server)  
Zorg dat je een cleint, cleint maakt met commando
```
yum install mailx
```
Declareer eerst naar wie de mail moet gestuurd worden
```
mail user@example.org
```
De termail zal het onderwerp vragen en daarna kan het bericht getypd worden. De commentline zal er ongeveer zo uitzien.
```
[root@MailCleint ~]# mail user@example.org
Subject: Hello
This is a test message.
Regards,

.
EOT 
```

# Handleiding voor het opzetten van Bravo1:
## Configureren van DNS-Server:
### Manueel configureren:
- Volg de handleiding [10_Steps_To_DNS](https://github.com/HoGentTIN/p3ops-green/blob/master/Servers/bravo1/Documentatie/10_Steps_To_DNS.md).

### Automatisch condifgureren:
*We gebruiken hier voor een [Ansible-rol](https://github.com/bertvv/ansible-role-bind) die gebaseerd is op BIND.*

* Type `vagrant up bravo1`.
* Als dit lukt zonder fouten dan is bravo1 werkend.

### Het nut van Bravo en Charlie!
* Bravo heeft informatie over alle server in het green.local netwerk. Deze werkt in een master/slave met Charlie.
* Dus als Bravo down gaat zal Charlie nog steeds de juiste info hebben. 

* Quebec spreekt met Bravo en Charlie als quebec info nodig heeft over het interne netwerk.
* Er zijn records toegevoegd voor de servers. Dus deze zouden nu bereikbaar moeten zijn.

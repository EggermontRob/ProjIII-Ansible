# Testrapport echo1

## Auteur(s) / Uitvoerder(s) testen:
- Lennert Mertens
- Maximilian Leire

## Uitgevoerde testen en het geleverde resultaat:

### Test 1: Netwerk configuratie 

- [x] IP adres werd goed ingesteld - moet 172.16.0.7 zijn
- [x] DNS adres werd goed ingesteld - moet www.green.local zijn

### Test 2: Website

- [x] Apache test page: Via webbrowser surfen naar 172.16.0.7
- [ ] Drupal page: Via webbrowser surfen naar 172.16.0.7/drupal7/install.php (Bij installatie) of 172.16.0.7/drupal7/ (Na installatie)
  - Werkt nog niet. Surfen naar dit adres levert volgende error op:
  ```
  Error
  The website encountered an unexpected error. Please try again later.
  Error messagePDOException: SQLSTATE[HY000] [2003] Can't connect to MySQL server on '172.16.0.37' (13) in lock_may_be_available() (line 167 of /usr/share/drupal7/includes/lock.inc).
  ```
#### 22/11/2018 Vervolg testing na aanpassingen

- Eerst inloggen op de server en verifiëren dat `httpd_can_network_connect_db --> on`, doen met dit commando: `getsebool -a | grep http`
- [x] Drupal page: Via webbrowser surfen naar 172.16.0.7/drupal7/install.php (Bij installatie) of 172.16.0.7/drupal7/ (Na installatie)
- Testing volgens testplan volledig geslaagd.
#### 03/12/2018 Testen op fysieke servers (Max L.)- Error wordt nog steeds weergegeven bij setup.#### 10/12/2018 Testen op fysieke servers (Max L.)- In orde
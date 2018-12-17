# p3ops-green
Project 3: Systeembeheer - Team Green

In deze repository zullen we alle bestanden opslaan die worden gebruikt voor het uitwerken van ons project. De repository wordt opgedeeld in verschillende submappen, gelieve de afgesproken mappenstructuur te respecteren en alle documentatie volgens de templates aan te vullen.

## Git werkwijze

**Volg deze werkwijze wanneer je lokaal wijzigingen wilt maken en pushen naar de master-branch**

**Spreek ook af met je teamleden dat je niet tegelijkertijd dezelfde bestanden bewerkt om merge-conflicten te voorkomen!**

1. Alvorens je begint te werken zorg je lokaal voor de laatste versie van de repository. De laatste updates kan u binnenhalen met:
```
$ git pull
```

2. Je werkt lokaal aan nieuwe code en wenst deze toe te voegen aan de master-branch
```bash
$ git add . 
# Je kan ook 1 of meerder bestanden toevoegen door de naam ervan mee te geven in plaats van het .
```

3. Geef een commit-boodschap mee aan de wijzigingen die je hebt gemaakt:
```bash
$ git commit -m"commit message"
```

4. Om conflicten te vermijden haal je nog eens de repository binnen alvorens je jouw wijzigingen pusht, dit doen we als volgt:
```
$ git pull --rebase
```

5. Je pusht je wijzigingen naar de repository
```
$ git push
```


## Richtlijnen Analyse
**Geen individuele Trello borden nodig**  
1 groepsbord waarop de voortgang van het project **ten alle tijden** te zien is en kan gevolgd worden  
**Dit bord moet dus steeds UP TO DATE zijn!**  

ELKE kaart eens uit backlog genomen krijgt een "Estimate". Nadien ook per prestatie een "Spent"  
Een kaart is max 4 uur (indien individueel), (6, uitz 8 uur indien groepskaart)  
ALGEMENE kaarten zoals (standup, teamoverleg, week 7 voormiddag, ...) zijn toegelaten en wijken dan ook af van bovenstaande regel  

Iedereen heeft een individueel weekrapport (te vinden op github) waarin zijn werk van de voorbije week word getoond. Dit kan op basis van screenshots van het groepstrellobord, aangevuld met eigen lijsten. Zo kan ik per week opvolgen wie welk team gedaan heeft.  
Optioneel: 1 gedeeld rekenblad met daarin per student / week zijn uren + de uren per team / week

Nog vragen? Contact opnemen met meneer Labijn.


## Links:
[Opdrachtomschrijving](/opdrachtomschrijving.md)  
[Algemene informatie](/algemeneinformatie.md)  
[Lastenboek](/lastenboek.md)  
[Documentatie](/documentatie)  
[vagrant-hosts.yml](/vagrant-hosts.yml)  
[vagrant-hosts.yml](/ansible/site.yml)

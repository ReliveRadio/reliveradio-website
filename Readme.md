<img src="https://raw.githubusercontent.com/ReliveRadio/reliveradio-ressources/master/github-navi/nav-system.png">

**master** [![Build Status](https://travis-ci.org/i42n/reliveradio-sendeplan-rails.png?branch=master)](https://travis-ci.org/i42n/reliveradio-sendeplan-rails)
, **develop** [![Build Status](https://travis-ci.org/i42n/reliveradio-sendeplan-rails.png?branch=develop)](https://travis-ci.org/i42n/reliveradio-sendeplan-rails) 

#ReliveRadio

Das [ReliveRadio](http://www.reliveradio.de) sendet rund um die Uhr Podcastformate aus ganz verschiedenen Themenbereichen. Zum einen, möchten wir mit dem ReliveRadio Menschen erreichen, die sich erst wenig oder gar nicht mit dem Format Podcast beschäftigt haben und so eine niederschwellige Einstiegsmöglichkeit bieten. Zum anderen soll das ReliveRadio aber auch Hörern die Gelegenheit geben, neue Podcastformate kennen zu lernen. Ansonsten möchten wir dazu beitragen, dass Podcasts auch mit geringer Bandbreite jederzeit auf dem Smartphone, dem Smart-TV, im Auto oder auf anderen Geräten gehört werden können.

[Du möchtest dich in das Projekt einbringen? Super! \o/](http://reliveradio.de/info/helfen)

#Überblick
Inzwischen gliedert sich das ReliveRadio auf technischer Ebene in mehrere Bereiche:

1. **[Airtime Radioautomation in PHP:](https://github.com/sourcefabric/Airtime)** Dient zur Verwaltung der Playlisten und zur Ansteuerung der Streamingserver.

2. **Webseite auf Ruby & Rails Basis** (dieses Repository): Zeigt die Sendepläne für den aktuellen Tag und beinhaltet eine Datenbank aller beteiligten Podcasts.

3. **[Webplayer zur Integration auf externen Webseiten](https://github.com/McCouman/ReLiveRadio-JsonP-about-Ajax)**

## Airtime Radioautomation
Mit Hilfe der Airtime Radioautomation werden für jeden Tag Playlisten zusammengestellt. Jede Playlist besteht aus mp3-Files, die dann hintereinander abgespielt werden. Die Airtime Installation bietet eine API, mit der sich der Sendeplan für den aktuellen Tag auslesen lässt.

* [http://reliveradio.de/api/today-info](http://reliveradio.de/api/today-info)
* [http://reliveradio.de/api/today-info?date=yesterday](http://reliveradio.de/api/today-info?date=yesterday)
* [http://reliveradio.de/api/today-info?date=tomorrow](http://reliveradio.de/api/today-info?date=tomorrow)
* [http://reliveradio.de/api/today-info?date=2013-06-25](http://reliveradio.de/api/today-info?date=2013-06-25)
* [http://reliveradio.de/api/upcoming-info](http://reliveradio.de/api/upcoming-info)
* [http://reliveradio.de/api/upcoming-info?num=100](http://reliveradio.de/api/upcoming-info?num=100)

```json
CODE
```

Darin sind aber nur begrenzt Informationen zum Podcast vorhanden - schließlich ist die Airtime Software eigentlich für Musik gedacht. Die Rails Installation auf ReliveRadio.de bedient sich nun der API der Airtime Installation und reichert die Podcasts mit Daten aus der eigenen Datenbank an.

#ReliveRadio API

##Zugriff auf Informationen zu einzelnen Podcasts

##Suche in der Datenbank

##Zugriff auf den Sendeplan

##Livestream URLs

# How to add a new feature

* open new feature with git flow
* write test
* implement
* add to changelog
* finish feature with git flow

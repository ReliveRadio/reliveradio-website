#ReliveRadio Sendeplan
Das hier ist eine Imprementierung für das [ReliveRadio](www.reliveradio.de). Es geht vor allem darum, den Sendeplan des aktuellen Tages mit einigen Metainformationen zu den Podcasts anzuzeigen.

*Achtung:*

* Die Datenbank ist *nicht* hier im Repository enthalten!
* Setze ein ordentliches Passwort in `app/controller/podcasts_controller.rb`

#Die eigene Rails Installation updaten:

* git pull
* bundle install
* rake assets:precompile
* cp db/production.sqlite2 db/production.bkp.sqlite3
* rake db:migrate
* Rails App neu starten
* DONE :)

#Komplette Dokumentation
Befindet sich in `doc/README.rdoc`
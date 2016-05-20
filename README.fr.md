# Web Hooker

Utilisez Web Hooker afin de pouvoir faire un miroir de votre gitlab sur Github :-)

## Installation sur Debian

### Pré-repuis
* Git: afin de cloner le dépôt
* Carton: gestionnaire des dépendances Perl, qui récupérera ce qui est nécessaire. Ne vous préoccupez pas des dépendances (mais vous pouvez tout de même lire le fichier cpanfile)
* Build-essentials: installation de plusieurs outils et bibliothèques qui peuvent être nécessaires.

```shell
apt-get install git build-essentials
cpan Carton
```

### Installation de Web Hooker

```shell
cd /opt/
git clone https://git.framasoft.org/luc/webhooker.git web_hooker
cd web_hooker
carton install
cp web_hooker.conf.template web_hooker.conf
vi web_hooker.conf
```

Editer le fichier `web_hooker.conf` afin qu'il corresponde à votre configuration.

Le fichier `web_hooker.conf` est documenté et auto-suffisant, mais, **s'il-vous-plaît**, prenez le temps de regarder attentivement l'option `authorized`.

Vous aurez besoin d'un compte qui a les droit de push sur le dépôt github. Indiquez les identifiants (login et mot de passe) dans le fichier `web_hooker.conf`.

Afin d'avoir plus d'options sur l'IP et le port d'écoute Web Hooker, changez la configuration dans le fichier `web_hooker.conf` 
(jetez un coup d'oeil à  http://mojolicio.us/perldoc/Mojo/Server/Hypnotoad#SETTINGS pour connaître les options disponibles).

### Lancer WebHooker au démarrage

#### initV

```shell
cp /opt/web_hooker/utilities/web_hooker.default /etc/default/web_hooker
sed -i 's/\/home\/git/\/opt/' /etc/default/web_hooker
cp /opt/web_hooker/utilities/web_hooker.init /etc/init.d/web_hooker
update-rc.d web_hooker defaults
service web_hooker start
service web_hooker status
```

#### systemd

```shell
cp /opt/web_hooker/utilities/web_hooker.service /etc/systemd/system
# A adapter à votre répetoire d'installation
vi /etc/systemd/system/web_hooker.service
systemctl daemon-reload
systemctl enable web_hooker.service
systemctl start web_hooker.service
```

C'est installé et en cours d'exécution, tout ce que vous avez à faire maintenant est d'ajouter un web hook à votre projet :

```
http://127.0.0.1:4242/<gh_username>/<gh_repo>
```

## Licence

Copyright 2015 Luc Didry

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## Contributeurs

* [@luc]<https://git.framasoft.org/u/luc>, développeur principal
* [@nikaro]<https://git.framasoft.org/u/nikaro>

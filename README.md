# Web Hooker

Use Web Hooker to mirror your gitlab to Github :-)

## Debian installation

### Prerequisites
* Git: to clone the repo
* Carton: Perl dependancies manager, it will get what you need, so don't bother for dependancies (but you can read the file cpanfile if you want).
* Build-essentials: Install several tools and libraries that you might need

```shell
apt-get install git build-essentials
cpan Carton
```

### Installation of Web Hooker

```shell
cd /opt/
git clone https://git.framasoft.org/luc/webhooker.git web_hooker
cd web_hooker
carton install
cp web_hooker.conf.template web_hooker.conf
vi web_hooker.conf
```

Edit `web_hooker.conf` to to comply with your configuration.

The `web_hooker.conf` file is self-documented but, **please**, have a close look at the `authorized` option.

You will need an account that has the right to push to the github repository. Put its credentials in `web_hooker.conf`.

For more options about how Web Hooker listen (interfaces, user, etc.), change the configuration in `web_hooker.conf` (have a look at http://mojolicio.us/perldoc/Mojo/Server/Hypnotoad#SETTINGS for the available options).

### Start WebHooker at boot

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
# Adapt it to your installation directory
vi /etc/systemd/system/web_hooker.service
systemctl enable web_hooker.service
systemctl start web_hooker.service
```

It's installed and running, all you have to do now is to add a web hook to your project :
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

## Contributors

* [@luc]<https://git.framasoft.org/u/luc>, main developer
* [@nikaro]<https://git.framasoft.org/u/nikaro>

# Web Hooker

Use Web Hooker to mirror your gitlab to Github :-)

## Debian 7 installation

### Prerequisites
* Git: to clone the repo
* Carton: Perl dependancies manager, it will get what you need, so don't bother for dependancies (but you can read the file cpanfile if you want).
* Build-essentials: Install several tools and libraries that you might need

```shell
apt-get install git carton build-essentials
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

For more options about how Web Hooker listen (interfaces, user, etc.), change the configuration in `web_hooker.conf` (have a look at http://mojolicio.us/perldoc/Mojo/Server/Hypnotoad#SETTINGS for the available options).

Start WebHooker at boot :
```shell
cp /opt/web_hooker/utilities/web_hooker.default /etc/default/web_hooker
sed -i 's/\/home\/git/\/opt/' /etc/default/web_hooker
cp /opt/web_hooker/utilities/web_hooker.init /etc/init.d/web_hooker
update-rc.d web_hooker defaults
service web_hooker start
service web_hooker status
```

It's installed, all you have to do now is to add a web hook to your project :
```
http://127.0.0.1:4242/<gh_username>/<gh_repo>
```

+++
date = "2015-07-07T23:41:00+02:00"
draft = false
title = "Installation"

+++

## Dependencies

You only need [Carton](https://metacpan.org/pod/Carton), a Perl module dependency manager. It will install the other dependencies locally.

But to install it, you'll need some tools, provided by the package `build-essential` on Debian and Ubuntu.

```
apt-get install build-essential
```

The best way to install Carton is:

```
cpan Carton
```

## Installation

Get the sources, then install the dependencies with Carton:

```
git clone https://git.framasoft.org/luc/erco.git
cd erco
carton install
cp erco.conf.template erco.conf
```

**IMPORTANT** See [Configuration](/doc/configuration.html) to know how to configure Erco and Exabgp.

## Systemd

You can use the provided file:

```
cp utilities/init/erco.service /etc/systemd/system
```

Edit `/etc/systemd/system/erco.service` in order to have `WorkingDir` equals to your installation directory, then:

```
systemctl daemon-reload
systemctl enable erco.service
```

You can now start Erco with:

```
systemctl start erco.service
```

## Web server

Since Erco uses [WebSocket](https://en.wikipedia.org/wiki/WebSocket), Nginx is recommended, but not mandatory: there is an Ajax fallback if WebSocket is not available.

```
cp utilities/nginx/erco.conf /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/erco.conf /etc/nginx/sites-enabled/
```

Edit `/etc/nginx/sites-available/erco.conf` to match your settings, then:

```
nginx -t && nginx -s reload
```

## That's all!

You can now [use](/doc/usage.html) your Erco!

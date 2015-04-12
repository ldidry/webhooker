# Web Hooker

Use Web Hooker to mirror your gitlab to Github :-)

## Installation

### Install Carton

Carton : Perl dependancies manager, it will get what you need, so don't bother for dependancies (but you can read the file cpanfile if you want).

### Install Web Hooker

After installing Carton :
```shell
git clone https://git.framasoft.org/luc/webhooker.git
cd webhooker
carton install
cp web_hooker.conf.template web_hooker.conf
vi web_hooker.conf
```

### Configuration

The `web_hooker.conf` file is self-documented but, **please**, have a close look at the `authorized` option.

## Usage
```
carton exec hypnotoad script/web_hooker
```

Yup, that's all, it will listen at "http://127.0.0.1:4242".

For more options (interfaces, user, etc.), change the configuration in `web_hooker.conf` (have a look at http://mojolicio.us/perldoc/Mojo/Server/Hypnotoad#SETTINGS for the available options).
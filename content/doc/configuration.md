+++
date = "2015-07-07T23:41:07+02:00"
draft = false
title = "Configuration"

+++

## Configuration of Exabgp

### Controlled block

You need to insert special sentences in your Exabgp's configuration file to tell to Erco where it can read and write routes.

These sentences are:

```
#ERCO CONTROLLED PART
#END OF ERCO CONTROLLED PART
```

You can insert these sentences more than one time, but be aware that the routes will be inserted between the two sentences for each `ERCO CONTROLLED PART` block.

### Access to Exabgp

You need to add a process in your configuration to allow Erco to send commands to Exabgp:

```
process socket {
  run "/var/www/erco/utilities/bin/exabgp-ws-server";
}
```

Bonus: this process allows you to use the [CLI interface](cli.html) to Exabgp.

### Exabgp's configuration example

```
group my_peers {

  router-id 198.51.100.1,
  local-address 198.51.100.2;
  local-as 65536;
  peer-as 65536;

  static {
    #ERCO CONTROLLED PART
    #END OF ERCO CONTROLLED PART
  }

  process socket {
    run "/var/www/erco/utilities/bin/exabgp-ws-server";
  }

  neighbor 198.51.100.3 {
    description "Bender_has_a_shiny_ass";
  }

}

```

## Configuration of Erco

The configuration template of Erco is self explained, but there is a thing you have to be warned about.

In the `hypnotoad` section, don't *EVER* change `workers => 1`.

![](/img/you_shall_not_pass.png)

```
    hypnotoad => {
        …
        # DO NOT CHANGE THIS OR YOU WILL GET INCONSISTENCIES IN THE ROUTES
        # YOU HAVE BEEN WARNED!
        workers => 1,
    },
```

**Explanation**: by default, `hypnotoad`, which is the Mojolicious web server, is multi-threaded. Each thread will get the configured routes from Exabgp's configuration at startup.
But when you change this configuration, the other threads won't read it again and are not aware of the modification.
It would result in some people seeing routes that doesn't exist anymore and/or routes that are already modified and/or not seeing newly created routes.

Disabling multi-threading with `workers => 1` prevents this bug.

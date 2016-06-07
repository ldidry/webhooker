+++
date = "2015-07-07T23:41:14+02:00"
draft = false
title = "cli"

+++

Erco comes with a CLI interface to Exabgp API.

Please note that this is not a client to Erco API.
Any configuration pushed with this tool (like announcing a new route) will be lost at Exabgp restart.

## Install the client in your $PATH

```
sudo ln -s /opt/erco/utilities/bin/exabgp-ws-client /usr/local/bin/
```

Please note that installing the client in your $PATH is not mandatory.
You can execute it with `/opt/erco/utilities/bin/exabgp-ws-client`

## Use the CLI

### Launch it

```
luc@erco:~$ exabgp-ws-client
Welcome on exabgp-ws-client.
Type 'help' to get some help, 'exit' or 'quit' to exit.
Easy, isn't it?
> 
```

### Commands

Everything is explained by calling `help` in the console.

```
> help
(c) 2015 Luc Didry <luc@didry.org>
This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

This program is just a way to manually enter commands using websockets.
Routes and flows syntax are parsed like normal configuration.

Commands:
    - quit|exit closes the client
    - version   returns the version of exabgp
    - reload    reloads the configuration - cause exabgp to forget all routes learned via external processes
    - restart   reloads the configuration and bounce all BGP session
    - shutdown  politely terminates all session and exit

WARNING : The result of the following commands will depend on the route, it could even cause the BGP session to drop.
          It could even cause the BGP session to drop, for example if you send flow routes to a router which does not support it.

The route will be sent to ALL the peers (there is no way to filter the announcement yet)

    - annouce route
      The multi-line syntax is currently not supported
      example: announce route 1.2.3.4 next-hop 5.6.7.8
    - withdraw route
      example: withdraw route (example: withdraw route 1.2.3.4 next-hop 5.6.7.8)
    - announce flow
      Exabgp does not have a single line flow syntax so you must use the multiline version indicating newlines with \n
      example: announce flow route {\n match {\n source 10.0.0.1/32;\n destination 1.2.3.4/32;\n }\n then {\n discard;\n }\n }\n
    - withdraw flow
      Exabgp does not have a single line flow syntax so you must use the multiline version indicating newlines with \n
      example: withdraw flow route {\n match {\n source 10.0.0.1/32;\n destination 1.2.3.4/32;\n }\n then {\n discard;\n }\n }\n

SHOW COMMANDS SHOULD NOT BE USED IN PRODUCTION AS THEY HALT THE BGP ROUTE PROCESSING
AND CAN RESULT IN BGP PEERING SESSION DROPPING - You have been warned

    - show neighbors displays the neighbor configured
    - show routes    displays routes which have been announced
```

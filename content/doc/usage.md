+++
date = "2015-07-08T00:49:11+02:00"
draft = false
title = "usage"

+++

## Using the web interface

### Check if Exabgp is running

Just have a look at the label under the "API" and "Reload Exabgp" buttons.

![](/img/exabgp_running.png)

This label is updated every second with websockets or with a continuous AJAX request if websockets are unavailables.

### Announcing a new route

Fill the form (don't forget to select at least one community) and click the "Add" button.

![](/img/new_route_1.png)

When asked to, confirm the addition of the network.

![](/img/new_route_2.png)

Done! Exabgp's configuration has been modified and Exabgp has been reloaded.

The new route has been added to the list.

![](/img/new_route_3.png)

### Modifying an announced route

Click on the pen icon on the line of the route you want to modify.

![](/img/mod_route_1.png)

Change what you want.

![](/img/mod_route_2.png)

Done. The route has been modified, so has been Exabgp's configuration and Exabgp has been reloaded.

![](/img/mod_route_3.png)

### Stop announcing a route

Click on the "X" icon on the line of the route you want to delete.

![](/img/del_route_1.png)

Confirm.

![](/img/del_route_2.png)

Done. The route has been delete, Exabgp's configuration has been modified and Exabgp has been reloaded.

### Reloading Exabgp manually

Simple: click on the "Reload Exabgp" button.

![](/img/exa_reload.png)

If the reload is successful, you will see a confirmation message. Otherwise, the message will explain why it failed.

![](/img/exa_reload_successfull.png)

### Sending commands to Exabgp

Choose the command you want to execute (the list of available commands depends of your Erco configuration).

![](/img/command_1.png)

Click on "Launch command".

![](/img/command_2.png)

Enjoy.

![](/img/command_3.png)

Click on the "Clear command output" to remove command output from the interface.

## Using the API

Erco comes with an API that you can request with tools like curl or wget, any tool that can do a HTTP request.
Every response is formatted as JSON.

You can access the API documentation whenever you want by clicking the blue "API" button on the web interface.

![](/img/api_button.png)

Please note that if you're not using Erco at the root of your web server, you'll need to add your URL prefix before the API URLs presented in the documentation.

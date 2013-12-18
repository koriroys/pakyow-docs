---
name: Development Tools
---

Pakyow provides several tools useful during development.

#### Server

The server command runs a local instance of a Pakyow application.

    console:
    pakyow server [environment]

If environment is not specified, the `default_environment` defined in the application will be used.

When starting the server, Pakyow will try the following handlers in order:

TODO puma?

  - thin
  - mongrel
  - webrick

You can run a specific handler by setting the `server.handler` config option (TODO reference).

#### Console

The console command loads an application into a REPL (like IRB).

    console:
    pakyow console [environment]

If environment is not specified, the `default_environment` defined in the application will be used.

Once the REPL is started, you can execute Ruby code against your application (TODO reference testing). If a file is changed, the REPL can be reloaded, like so:

    irb:
    reload
    Reloading...

#### Rake Tasks

Several rake tasks are bundled with an application. Run `rake --tasks` inside an application folder to see the list.

    console:
    rake --tasks
    

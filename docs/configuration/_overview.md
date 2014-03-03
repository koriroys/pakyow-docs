---
name: Configuration Options
---

An app can be configured in the `configure` block for the appropriate environment. Configuration defined in the `global` block will be available across all environments.

Below is a list of configuration options.

#### Application

*app.auto_reload*  
Whether or not the app should be reloaded on every request.

*app.errors_in_browser*  
Whether or not exceptions should be displayed in the browser or handled internally.

*app.log*  
Whether or not the logger should be used.

*app.log_output*  
Whether or not `$stdout` should write to the log.

*app.root*  
The root directory of the application.

*app.resources*  
The path to the resources folder (default: 'public').

*app.src_dir*  
The path to the source code (default: 'app/'lib).

*app.default_action*  
The name of the default action (default: 'index')

*app.ignore_routes*  
Whether or not to ignore all defined routes (useful for running just the front-end prototype).

*app.default_environment*  
The default environment for an app (default: 'development').

*app.path*  
The path to file containing the application definition.

*app.static*  
Whether or not static files should be handled by Pakyow.

#### Server

*server.port*  
The port the application should run on (default: '3000').

*server.host*  
The host the application should run on (default: '0.0.0.0').

#### Logger

*logger.path*  
The path to the logs (default: 'logs').

*logger.name*  
The name of the logfile (default: 'requests').

*logger.sync*  
Whether or not the logs should be synced (default: 'true').

*logger.auto_flush*  
Whether or not the logs should be auto flushed (default: 'true').

*logger.colorize*  
Whether or not the logs should be colorized (default: 'true').

*logger.level*  
What level of severity the logs care about (default: 'debug').

#### Cookies

*cookies.path*  
The path cookies should be created at (default: '/').

*cookies.expiration*  
When cookes should expire (default: 'one week').

#### Presenter

*presenter.view_stores*  
The configured view stores for the app.

*presenter.default_views*  
The default views for each view store (default: 'pakyow.html').

*presenter.template_dirs*  
The template directories for each view store (default: '_templates').

*presenter.scope_attribute*  
The attribute used for labeling scopes (default: 'data-scope').

*presenter.prop_attribute*  
The attribute used for labeling props (default: 'data-prop').

#### Mailer

*mailer.default_sender*  
The default sender name (default: 'Pakyow').

*mailer.default_content_type*  
The default content type (default: 'text/html; charset=UTF-8').

*mailer.delivery_method*  
The delivery method to use (default: 'sendmail').

*mailer.delivery_options*  
Other delivery options passed to Mail (default: 'enable_starttls_auto: false').

*mailer.encoding*  
The encoding to use (default: 'UTF-8').

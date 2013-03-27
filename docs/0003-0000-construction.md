---
name: Compiling Views
---

An application's views are grouped into a view store, which is a hierarchical set of markup files that resembles the routes for an application. These files are compiled together to build the view for a particular request. 

Here's a simple view hierarchy:

    views/
      main.html
      pakyow.html
      sub/
        main.html

View compilation beings by identifying the view path. By default, this is the request path (if the request path is `/sub`, the view path is `/sub`, and so on). Compilation is driven by the hierarchy at the working view path.

In the case of paths with arguments, the view path is collapsed down to the path sans arguments. For example, the view path for the `/foo/:bar` route is just `/foo`.

#### Root Views

Next, the root view for the view path is found (the root view is the view that drives the rest of the compilation process, and typically contains the general page structure; think of it as the template file). By default, the root view is named `pakyow.html`. This is the only root view in the example above.

#### Containers &amp; Content Views

Views define containers that mix in content views when compiled. A container is defined using the `data-container` attribute. For example, assume `pakyow.html` defines a single container named `main`:

    html:
    <html>
    <body>
      <div data-container="main">
        Main Content Goes Here
      </div>
    </body>
    </html>

Matching content views are compiled into the container. For example, at the `/` view path, the `main.html` content view would be compiled into the `main` container. Assuming `main.html` looked like:

    html:
    <p>
      This is main content.
    </p>

The compiled view at `/` would look like:

    html:
    <html>
    <body>
      <div data-container="main">
        <p>
          This is main content.
        </p>
      </div>
    </body>
    </html>

At the `/sub` view path, the `sub/main.html` content view. Assuming `sub/main.html` looked like:

    html:
    <p>
      This is sub-main content.
    </p>

The compiled view at `/sub` would look like:

    html:
    <html>
    <body>
      <div data-container="main">
        <p>
          This is sub-main content.
        </p>
      </div>
    </body>
    </html>

Containers can be defined from any view, and even defined multiple times in the same view. It just works.

#### Root View Override

The root view can be overridden at any point in the hierarchy by appending it to the folder name. For example, say a second root view was added called `another_root.html`. Using it for the `/sub` view path would look like:

    views/
      another_root.html
      main.html
      pakyow.html
      sub.another_html/
        main.html


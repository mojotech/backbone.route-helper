[![Build Status](https://travis-ci.org/mojotech/backbone.route-helper.png)](https://travis-ci.org/mojotech/backbone.route-helper)

## Backbone and Marionette Route Helper

Add helper methods for your backbone and marionette routes.

This works only for the simple cases of routes with string action names that can be differentiated by action name and arity.  If you would like to provide custom path generation you can simply define the same method on the router manually.

Given the router:

```coffeescript
  class TodoRouter extends Backbone.Router
    routes:
      "todos/new": "show"
      "todos/:id": "show"
      "todos": "index"

  window.Routes.todo = new TodoRouter()
```

You can generate URL's for the routes with the following code:

```coffeescript
  Routes.todo.indexPath() is '/todos'
  Routes.todo.showPath() is '/todos/new'
  Routes.todo.showPath(1) is '/todos/1'
```

You can manually override path generation in your router as well:

```coffeescript
  class TodoRouter extends Backbone.Router
    routes:
      "todos": "index"
      
    indexPath: -> "/some-other-url"
  
  router = new TodoRouter()
  
  router.indexPath() is '/some-other-url'
```

### Usage / Installation

Just include the library after backbone but before instantiating any routers, it will patch `Backbone.Router`.

### Notes

If two routes share the same route name and arity, the library will be unable to determine which is canonical since javascript object property order is not guarunteed.  If you run in to this issue, you can call the route method outside of the hash in specific order, and the last encountered value will be considered canonical.

Inspired by [backbone-named-routes](https://github.com/drtangible/backbone-named-routes)

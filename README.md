## Backbone Route Helper

Add rails style methods for your backbone and marionette routes.

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
  Routes.todo.index() == '/todos'
  Routes.todo.show() == '/todos/new'
  Routes.todo.show(1) == '/todos/1'
```

Just include the library after backbone but before instantiating any routers, it will patch `Backbone.Router`.


Inspired by [backbone-named-routes](https://github.com/drtangible/backbone-named-routes)

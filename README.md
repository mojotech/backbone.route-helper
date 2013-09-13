## Backbone Route Helper

Add rails style methods for your backbone and marionette routes.

Given the router:

```
  class TodoRouter extends Backbone.Router
    routes: 
      "todos": "index"
      "todos/new": "show"
      "todos/:id": "show"
      
  window.Routes.todo = new TodoRouter()
```

You can generate URL's for the routes with the following code:

```
  Routes.todo.index() == '/todos'
  Routes.todo.show() == '/todos/new'
  Routes.todo.show(1) == '/todos/1'
```


Inspired by [backbone-named-routes](https://github.com/drtangible/backbone-named-routes)

do (Backbone, _) ->
  addRoute = (name, route, options = {}) ->
    _.defaults options,
      includeRoot: false

    # Create key to store path patterns for this route name.
    @_patterns = @_patterns or {}
    data = @_patterns[name] or {}
    @_patterns[name] = data

    # Store the route pattern for the combination of this route name and the
    # number of path params defined in the pattern.
    numberOfParams = if route.match(/\:\w+/g) then route.match(/\:\w+/g).length else 0
    data[numberOfParams] = route

    # Create the named route helper method for this route name.
    @[name + 'Path'] = ->
      args = Array.prototype.slice.call(arguments)
      hasQueryParams = _(args[args.length-1]).isObject()
      numberOfParams = if hasQueryParams then arguments.length - 1 else arguments.length
      routePattern = data[numberOfParams]
      queryParams = if hasQueryParams then args.pop() else null

      routePattern = prependRoot(routePattern) if options.includeRoot

      pathFor(routePattern, args, queryParams)

  prependRoot = (route) ->
    history = Backbone.history

    #if (!history || !history.options || history.options.root == "/") return route;
    return route if not history? or not history.options? or history.options.root is '/'

    routeWithRoot = history.options.root + '/' + route
    routeWithRoot.replace('//', '/')

  pathFor = (pathPattern, urlParams, queryParams) ->
    path = pathPattern
    path = '/' + path if path.charAt(0) isnt '/'

    for param in urlParams
      path = path.replace(/\:\w+/, param)

    filteredQueryParams = filterObject(queryParams)

    if filteredQueryParams and not _.isEmpty(filteredQueryParams)
      path += "?" + $.param(filteredQueryParams)

    path

  # Filters out `undefined` and `null` values
  filterObject = (object) ->
    filteredObject = {}

    for k,v of object
      filteredObject[k] = value if has(object, k) and value?

    filteredObject

  # cache reference to `Object.prototype.hasOwnProperty`
  hasOwnProperty = Object::hasOwnProperty
  has = (object, key) -> hasOwnProperty.call(object, key)

  # store original _bindRoutes method for later
  originalRoute = Backbone.Router::route

  Backbone.Router::route = (route, name, callback) ->
    originalRoute.call(@, route, name, callback)
    addRoute.call @, name, route

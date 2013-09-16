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
    numberOfParams = route.match(/\:\w+/g)?.length or 0
    data[numberOfParams] = route

    # Create the named route helper method for this route name.
    @[name + 'Path'] = ->
      args = Array::slice.call(arguments)
      hasQueryParams = _(args[args.length-1]).isObject()
      numberOfParams = if hasQueryParams then arguments.length - 1 else arguments.length
      routePattern = data[numberOfParams]
      queryParams = if hasQueryParams then args.pop() else null

      routePattern = prependRoot(routePattern) if options.includeRoot

      pathFor(routePattern, args, queryParams)

  prependRoot = (route) ->
    history = Backbone.history

    return route if (history?.options?.root or '/') is '/'

    routeWithRoot = history.options.root + '/' + route
    routeWithRoot.replace('//', '/')

  pathFor = (pathPattern, urlParams, queryParams) ->
    path = pathPattern
    path = '/' + path if path.charAt(0) isnt '/'
    path = path.replace(/\:\w+/, param) for param in urlParams

    filteredQueryParams = filterObject(queryParams)

    unless _.isEmpty(filteredQueryParams)
      path += "?" + $.param(filteredQueryParams)

    path

  # Filters out `undefined` and `null` values
  filterObject = (object) ->
    filteredObject = {}

    for k,v of object
      filteredObject[k] = value if _.has(object, k) and value?

    filteredObject

  # store original _bindRoutes method for later
  originalRoute = Backbone.Router::route

  Backbone.Router::route = (route, name, callback) ->
    originalRoute.call(@, route, name, callback)
    addRoute.call @, name, route

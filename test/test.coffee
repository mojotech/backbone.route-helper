should = require 'should'
global.$ = require 'jquery'
global._ = require 'underscore'
global.Backbone = require 'backbone'
require '../backbone.route-helper.coffee'
global.Marionette = require 'backbone.marionette'

should.Assertion::propertyEndingWith = (suffix) ->
  _(this.obj).chain().keys().filter( (k) -> k.indexOf(suffix, k.length - suffix.length) isnt -1).value().length.should.eql 0

describe 'Backbone Route Helper', ->
  testRoutes =
    'todos/new': 'show'
    'todos/:todo_id/comments/:id': 'showComment'
    'todos/:id': 'show'
    'todos': 'index'

  beforeEach ->
    delete Backbone.history.options

  describe 'Backbone.Router', ->
    todo = null

    beforeEach ->
      class TodoRouter extends Backbone.Router
        routes: testRoutes

      todo = new TodoRouter()

    it 'handles path routes', ->
      todo.showPath().should.eql('/todos/new')
      todo.showCommentPath(2, 3).should.eql('/todos/2/comments/3')
      todo.showPath(1).should.eql('/todos/1')
      todo.indexPath().should.eql('/todos')

    it 'respects Backbone.history.options.root', ->
      Backbone.history.options = {}
      Backbone.history.options.root = '/test/'

      todo.showPath().should.eql('/test/todos/new')
      todo.showPath(1).should.eql('/test/todos/1')
      todo.indexPath().should.eql('/test/todos')

    it 'handles query string', ->
      todo.indexPath(sort: 'asc').should.eql('/todos?sort=asc')

  describe 'Alternative route syntax', ->
    it 'ignores regex patterns', ->
      class MyRouter extends Backbone.Router
        initialize: ->
          @route /^\/test$/, 'index'

      router = new MyRouter()

      router.should.not.have.property 'indexPath'

    it 'ignores function actions', ->
      class MyRouter extends Backbone.Router
        routes:
          '/test': ->

      router = new MyRouter()

      router.should.not.have.propertyEndingWith('Path')

    it 'assumes last unique action/parity pair is canonical', ->
      class MyRouter extends Backbone.Router
        initialize: ->
          @route '/test/archive', 'index'
          @route '/test', 'index'

      router = new MyRouter()

      router.indexPath().should.eql '/test'

    it 'allows user to overide path generation', ->
      myPathMethod = -> '/something'

      class MyRouter extends Backbone.Router
        routes:
          '/test': 'index'
        indexPath: myPathMethod

      router = new MyRouter()

      router.indexPath.should.eql myPathMethod
      router.indexPath().should.eql '/something'

  describe 'Marionette.AppRouter', ->
    todo = null

    beforeEach ->
      class TodoRouter extends Marionette.AppRouter
        routes: testRoutes

      todo = new TodoRouter()

    it 'handles path routes', ->
      todo.showPath().should.eql('/todos/new')
      todo.showCommentPath(2, 3).should.eql('/todos/2/comments/3')
      todo.showPath(1).should.eql('/todos/1')
      todo.indexPath().should.eql('/todos')

    it 'handles query string', ->
      todo.indexPath(sort: 'asc').should.eql('/todos?sort=asc')

should = require 'should'
global._ = require 'underscore'
global.Backbone = require 'backbone'
require '../backbone.route-helper.coffee'
global.Marionette = require 'backbone.marionette'

describe 'Backbone Route Helper', ->
  beforeEach ->
    delete Backbone.history.options

  describe 'Backbone.Router', ->
    todo = null

    beforeEach ->
      class TodoRouter extends Backbone.Router
        routes:
          'todos/new': 'show'
          'todos/:id': 'show'
          'todos': 'index'

      todo = new TodoRouter()

    it 'works', ->
      todo.showPath().should.eql('/todos/new')
      todo.showPath(1).should.eql('/todos/1')
      todo.indexPath().should.eql('/todos')

    it 'respects Backbone.history.options.root', ->
      Backbone.history.options = {}
      Backbone.history.options.root = '/test/'

      todo.showPath().should.eql('/test/todos/new')
      todo.showPath(1).should.eql('/test/todos/1')
      todo.indexPath().should.eql('/test/todos')

  describe 'Marionette.AppRouter', ->
    todo = null

    beforeEach ->
      class TodoRouter extends Marionette.AppRouter
        routes:
          'todos/new': 'show'
          'todos/:id': 'show'
          'todos': 'index'

      todo = new TodoRouter()

    it 'works', ->
      todo.showPath().should.eql('/todos/new')
      todo.showPath(1).should.eql('/todos/1')
      todo.indexPath().should.eql('/todos')

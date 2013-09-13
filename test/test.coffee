should = require 'should'
global._ = require 'underscore'
global.Backbone = require 'backbone'
require '../backbone.route-helper.coffee'
#global.Marionette =

describe 'Backbone Route Helper', ->
  describe 'Backbone.Router', ->
    todo = null

    beforeEach ->
      class TodoRouter extends Backbone.Router
        routes:
          "todos/new": "show"
          "todos/:id": "show"
          "todos": "index"

      todo = new TodoRouter()

    it 'works', ->
      todo.showPath().should.eql('/todos/new')
      todo.showPath(1).should.eql('/todos/1')
      todo.indexPath().should.eql('/todos')

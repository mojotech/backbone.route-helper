cs = require('coffee-script')
fs = require('fs')
uglify = require('uglify-js')

task 'build', 'compiles to source', ->
  console.log 'Compiling source'
  source = fs.readFileSync(__dirname + '/backbone.route-helper.coffee', 'utf8')
  compiled = cs.compile(source)
  fs.writeFileSync(__dirname + '/backbone.route-helper.js', uglify.minify(compiled, {fromString: 1}).code)

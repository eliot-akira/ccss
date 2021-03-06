fs = require 'fs'

extend = (object, properties) ->
  for key, value of properties
    object[key] = value
  object

@compile = (rules) ->
  css = ''

  for selector, pairs of rules
    declarations = ''
    nested = {}

    #add mixins to the current level
    if {mixins} = pairs
      delete pairs.mixins
      for mixin in [].concat mixins
        extend pairs, mixin

    #a pair is either a css declaration, or a nested rule
    for key, value of pairs
      if typeof value is 'object'
        children = []
        split = key.split /\s*,\s*/
        children.push "#{selector} #{child}" for child in split
        nested[children.join ','] = value
      else
        #borderRadius -> border-radius
        key = key.replace /[A-Z]/g, (s) -> '-' + s.toLowerCase()
        declarations += "  #{key}: #{value};\n"

    declarations and css += "#{selector} {\n#{declarations}}\n"

    css += @compile nested

  css

@compileFile = (infile, outfile) ->
  rules = require process.cwd() + '/' + infile
  css = @compile rules
  outfile or= infile.replace /coffee$/, 'css'
  fs.writeFileSync outfile, css

#!/usr/bin/env coffee

boxShadow = (arg) ->
  '-webkit-box-shadow': arg
  '-moz-box-shadow':    arg
  'box-shadow':         arg

lighten = saturate = (color, diff) ->#TODO
  color

root =
  '.box': do ->
    base = '#f938ab'
    color: saturate base, '5%'
    'border-color': lighten base, '5%'
    div:
      boxShadow '0 0 5px 0.4'

css = ''

parse = (selector, declarations) ->
  children = {}

  for property, value of declarations
    if typeof value is 'object'
      delete declarations[property]
      children["#{selector} #{property}"] = value

  css += selector + ' {\n'
  for property, value of declarations
    css += "  #{property}: #{value};\n"
  css += '}\n'

  for selector, declarations of children
    parse selector, declarations

for selector, declarations of root
  parse selector, declarations

console.log css

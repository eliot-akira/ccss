CoffeeScript CSS

ccss:
    foo:
      hurr: 'durr'
      bar:
        lol: 'wat'

css:
    foo {
      hurr: durr;
    }
    foo bar {
      lol: wat;
    }

the core of the compiler is simply this:

iterate over the key / values of an object; if the value is another object,
append the key to the current selector, and recurse; else generate css.

if you want logic, wrap it up in a function which returns an object:

ccss:
    '.foo': do ->
      opaque = 1
      translucent = opaque / 2
      img:
        opacity: translucent
      'img:hover':
        opacity: opaque

css:
    .foo img {
      opacity: .5;
    }
    .foo img:hover {
      opacity: 1;
    }

as seen in the above example, we have to quote keys that confuse coffee-script.

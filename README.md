commonjs-rhino
==============

CommonJS support for Rhino, in Ruby (JRuby specifically). commonjs-rhino allows you to create JavaScript contexts that contain a `require` method you can use to load CommonJs modules.

## Installation

`gem install commonjs-rhino`

Then, require it somewhere in your code:

```ruby
require 'commonjs-rhino'
```

Please be aware this gem requires Mozilla's Rhino JavaScript environment, which means Rhino will need to be somewhere in your Java classpath. commonjs-rhino was developed using jbundler, which I recommend for Java dependency management. It's pretty easy to set up, here's a quick guide: Run `gem install jbundler`, then add `require 'jbundler'` in your project before any `java_import` statements are executed. In other words, your project should contain these lines in this order:

```ruby
require 'jbundler'
require 'commonjs-rhino'
# require other jbundler-compatible gems
```

## Usage

Let's say you have this nice little CommonJs JavaScript module you'd like to use in Rhino. The module exists on disk at `/path/to/camertron/teapot.js`:

```javascript
(function() {
  module.exports.strVariable = 'foobarbaz';
  module.exports.func = function() {
    return "I'm a little teapot";
  };
}).call();
```

Create a commonjs-rhino context, point it at your modules, and require away:

```ruby
context = CommonjsRhino.create_context(['/path/to/camertron'])
context.eval('var hello = require("camertron/teapot")')
context.eval('hello.strVariable')  # => 'foobarbaz'
```

It's that easy!

## Requirements

1. [JRuby](http://jruby.org/)
2. [Rhino](https://developer.mozilla.org/en-US/docs/Mozilla/Projects/Rhino) on your classpath (see above).

## Running Tests

`bundle exec rspec` should do the trick :)

## Authors

* Cameron C. Dutro: http://github.com/camertron

[![Build Status](https://travis-ci.org/camertron/commonjs-rhino.svg)](https://travis-ci.org/camertron/commonjs-rhino) [![Code Climate](https://codeclimate.com/github/camertron/commonjs-rhino/badges/gpa.svg)](https://codeclimate.com/github/camertron/commonjs-rhino) [![Test Coverage](https://codeclimate.com/github/camertron/commonjs-rhino/badges/coverage.svg)](https://codeclimate.com/github/camertron/commonjs-rhino/coverage)

commonjs-rhino
==============

CommonJs support for Rhino, in Ruby (JRuby specifically). commonjs-rhino allows you to create JavaScript contexts that contain a `require` method you can use to load CommonJs modules.

## Installation

`gem install commonjs-rhino`

Then, require it somewhere in your code:

```ruby
require 'commonjs-rhino'
```

Please be aware this gem requires Mozilla's Rhino JavaScript environment, which means Rhino will need to be somewhere in your Java classpath. commonjs-rhino was developed using [expert](https://github.com/camertron/expert). You may find it convenient to use expert in your own project to manage commonjs-rhino's Java dependencies. Just add expert to your bundle and add these lines in your project:

```ruby
require 'expert'
Expert.environment.require_all

require 'commonjs-rhino'
# your code here
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

You can also evaluate files with the handy `eval_file` method:

```ruby
context.eval_file('/path/to/file.js')
```

## Requirements

1. [JRuby](http://jruby.org/)
2. [Rhino](https://developer.mozilla.org/en-US/docs/Mozilla/Projects/Rhino) in your classpath (see above).

## Running Tests

`bundle exec rspec` should do the trick :)

## Authors

* Cameron C. Dutro: http://github.com/camertron

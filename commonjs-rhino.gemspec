$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'commonjs-rhino/version'

Gem::Specification.new do |s|
  s.name     = "commonjs-rhino"
  s.version  = ::CommonjsRhino::VERSION
  s.authors  = ["Cameron Dutro"]
  s.email    = ["camertron@gmail.com"]
  s.homepage = "http://github.com/camertron"

  s.description = s.summary = "CommonJS support for Rhino, in Ruby."
  s.requirements << "jar 'org.mozilla:rhino', '1.7R4'"

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true

  s.require_path = 'lib'
  s.files = Dir["{lib,spec}/**/*", "Gemfile", "History.txt", "README.md", "Rakefile", "commonjs-rhino.gemspec"]
end

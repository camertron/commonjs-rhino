# encoding: UTF-8

require 'spec_helper'

describe CommonjsRhino::Context do
  let(:rhino) { CommonjsRhino }

  # Privileged URIs are like a load path, except that the last
  # part of the path must also be used when requiring the module.
  let(:privileged_uris) { [File.expand_path('../fixtures', __FILE__)] }

  # Notice the module here has to include a prefix of 'fixtures/'
  # even though the path we added above ends with the same.
  let(:test_module) { 'fixtures/test_module' }

  # Any scripts you load from disk should be referenced via paths,
  # not via module syntax (i.e. include file extensions, etc)
  let(:test_script) { File.expand_path('../fixtures/test_script.js', __FILE__) }

  before(:each) do
    @context = rhino.create_context(privileged_uris)
  end

  describe '#eval' do
    it 'evaluates javascript code' do
      expect(@context.eval('1 + 2 + 3')).to eq(6)
    end

    it 'supports loading modules' do
      @context.eval("var foo = require('#{test_module}');")
      expect(@context.eval('foo.strVariable;')).to eq('foobarbaz')
      expect(@context.eval('foo.func();')).to eq("I'm a little teapot")
    end

    it 'does not allow modules to be loaded from non-privileged uris' do
      expect(
        lambda { @context.eval("var foo = require('non/existent');") }
      ).to raise_error(Java::OrgMozillaJavascript::JavaScriptException)
    end
  end

  describe '#eval_file' do
    it 'loads and interprets a file' do
      @context.eval_file(test_script)
      expect(@context.eval('hello')).to eq('world')
    end
  end
end

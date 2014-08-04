# encoding: UTF-8

require 'java'

java_import 'java.io.FileReader'
java_import 'org.mozilla.javascript.commonjs.module.ModuleScriptProvider'
java_import 'org.mozilla.javascript.commonjs.module.provider.ModuleSourceProvider'
java_import 'org.mozilla.javascript.commonjs.module.provider.SoftCachingModuleScriptProvider'
java_import 'org.mozilla.javascript.commonjs.module.provider.UrlModuleSourceProvider'
java_import 'org.mozilla.javascript.commonjs.module.Require'
java_import 'org.mozilla.javascript.commonjs.module.RequireBuilder'

# http://stackoverflow.com/questions/11074836/resolving-modules-using-require-js-and-java-rhino
module CommonjsRhino
  class Context
    attr_reader :rhino_context, :shared_scope, :require_base_paths

    def initialize(shared_scope, require_base_paths)
      @shared_scope = shared_scope
      @require_base_paths = require_base_paths
      nil
    end

    def eval_file(file)
      with_context do |context|
        context.evaluateReader(
          shared_scope, FileReader.new(file), nil, 1, nil
        )
      end
    end

    def eval(str)
      with_context do |context|
        context.evaluateString(shared_scope, str, nil, 1, nil)
      end
    end

    private

    def with_context
      context = Java::OrgMozillaJavascript::Context.enter
      yield context
    ensure
      context.java_send(:exit)
      nil
    end
  end

  def self.create_context(require_base_paths = [Dir.getwd])
    require_base_paths = Array(require_base_paths)

    source_provider = UrlModuleSourceProvider.new(
      require_base_paths.map do |base_path|
        Java::JavaNet::URI.new("file://#{base_path}")
      end, nil
    )

    script_provider = SoftCachingModuleScriptProvider.new(source_provider)

    builder = RequireBuilder.new
      .setModuleScriptProvider(script_provider)
      .setSandboxed(false)

    context = Java::OrgMozillaJavascript::Context.enter
    top_level_scope = context.initStandardObjects()
    req = builder.createRequire(context, top_level_scope)
    req.install(top_level_scope)
    context.java_send(:exit)

    CommonjsRhino::Context.new(top_level_scope, require_base_paths)
  end
end

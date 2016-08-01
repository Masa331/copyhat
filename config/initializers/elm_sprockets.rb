# require 'open3'
# require 'tempfile'
#
# require 'pry'; binding.pry
# class ElmCompiler < Sprockets::Processor
#   def self.default_mime_type
#     'text/x-elm'
#   end
#
#   def evaluate(context, _locals)
#     pathname = context.pathname.to_s
#
#     if pathname =~ /\.js.*\.elm$/
#       add_elm_dependencies pathname, context
#
#       ElmCompiler.compile pathname
#     else
#       ""
#     end
#   end
#
#   private
#
#   # Add all Elm modules imported in the target file as dependencies, then
#   # recursively do the same for each of those dependent modules.
#   def add_elm_dependencies(filepath, context)
#     # Turn e.g. ~/NoRedInk/app/assets/javascripts/Quiz/QuestionStoreAPI.js.elm
#     # into just ~/NoRedInk/app/assets/javascripts/
#     dirname = context.pathname.to_s.gsub Regexp.new(context.logical_path + ".+$"), ""
#
#     File.read(filepath).each_line do |line|
#       # e.g. `import Quiz.QuestionStore exposing (..)`
#       match = line.match(/^import\s+([^\s]+)/)
#
#       unless match.nil?
#         # e.g. Quiz.QuestionStore
#         module_name = match.captures[0]
#
#         # e.g. Quiz/QuestionStore
#         dependency_logical_name = module_name.gsub(".", "/")
#
#         # e.g. ~/NoRedInk/app/assets/javascripts/Quiz/QuestionStore.elm
#         dependency_filepath = dirname + dependency_logical_name + ".elm"
#
#         # If we don't find the dependency in our filesystem, assume it's because
#         # it comes in through a third-party package rather than our sources.
#         if File.file? dependency_filepath
#           context.depend_on dependency_logical_name
#
#           add_elm_dependencies dependency_filepath, context
#         end
#       end
#     end
#   end
#
#   def self.compile(pathname)
#     temp_file = Tempfile.new ['compiled_elm_output', '.js']
#     cmd = (`npm bin`).strip + "/elm-make"
#
#     begin
#       # need to specify LANG or else build will fail on jenkins
#       # with error "elm-make: elm-stuff/build-artifacts/NoRedInk/NoRedInk/1.0.0/Quiz-QuestionStore.elmo: hGetContents: invalid argument (invalid byte sequence)"
#       Open3.popen3({'LANG' => 'en_US.UTF-8'}, cmd, pathname.to_s, "--yes", "--output", temp_file.path, chdir: Rails.root) do |_stdin, stdout, stderr, wait_thr|
#         compiler_output = stdout.gets(nil)
#         stdout.close
#
#         compiler_err = stderr.gets(nil)
#         stderr.close
#
#         process_status = wait_thr.value
#
#         if process_status.exitstatus != 0
#           raise compiler_err
#         end
#       end
#
#       temp_file.read
#     ensure
#       temp_file.unlink
#     end
#   end
# end
#

class MySprocketsExtension
  def self.call(input)
    { data: input[:data] + "/* Honvo */" }
  end
end

require 'sprockets/processing'
extend Sprockets::Processing


Rails.application.config.assets.configure do |env|
  env.register_mime_type 'text/x-elm', extensions: ['.elm']
  # env.register_preprocessor 'text/x-elm', MySprocketsExtension
  env.register_transformer 'text/x-elm', 'application/javascript', MySprocketsExtension



  # env.register_mime_type 'text/x-elm', extensions: ['.elm']
  # env.register_preprocessor '.elm', ElmSprockets::Processor
#   # Rails.application.config.assets.register_engine('.elm', ElmCompiler)
#   # Rails.application.config.assets.register_mime_type('text/x-elm', '.elm')
end


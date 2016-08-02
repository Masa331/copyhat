require 'pathname'

# below is a pretty shitty code... :( :D wants refactoring!!

class MySprocketsExtension
  def self.call(input)
    filename = input[:filename]
    pathname = Pathname.new filename
    compile_dir = pathname.dirname
    current_dir = Dir.getwd

    cmd = "elm make #{pathname.basename.to_s} --output Main.js"

    Dir.chdir compile_dir do
      `#{cmd}`
    end

    data = File.read compile_dir + "Main.js"
    File.delete compile_dir + "Main.js"

    { data: data }
  end
end

require 'sprockets/processing'
extend Sprockets::Processing


Rails.application.config.assets.configure do |env|
  env.register_mime_type 'text/x-elm', extensions: ['.elm']
  env.register_transformer 'text/x-elm', 'application/javascript', MySprocketsExtension
end

require 'pathname'
require 'open3'

class ElmSprockets
  class CompileError < StandardError; end

  def self.call(input)
    input_file = Pathname.new input[:filename]
    output_file = Rails.root.join("tmp", "cache", "assets", "elm", "#{input[:name]}.js")

    cmd = "elm make #{input_file} --output #{output_file}"

    Open3.popen3(cmd, chdir: Rails.root) do |_in, out, err, t|
      compiler_out = out.read
      compiler_err = err.read
      if t.value != 0
        raise CompileError, compiler_err
      end
    end

    { data: File.read(output_file) }
  end
end

require 'sprockets/processing'
extend Sprockets::Processing


Rails.application.config.assets.configure do |env|
  env.register_mime_type 'text/x-elm', extensions: ['.elm']
  env.register_transformer 'text/x-elm', 'application/javascript', ElmSprockets
end

require 'highlighter/markdown'

module Highlighter
  class Converter
    def self.markdown2html(input_file, options)
      input = File.read(input_file)
      html = Markdown.new(options).to_html(input)
      File.open(options.output_path, 'w') do |f|
        f.puts html
      end
    end
  end
end
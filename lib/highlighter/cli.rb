require 'clamp'
require 'highlighter/converter'
require 'highlighter/convert_options'
require 'highlighter/utils/prism'

module Highlighter
  class Cli < Clamp::Command

    option '--[no-]highlight', :flag, 'syntax highlight output or not', :default => true

    option %w(-t --theme), 'THEME', 'theme to use when highlighting',
           :attribute_name => :theme, :default => :default do |t|
      theme = t.strip.to_sym
      signal_usage_error "'#{t.strip}' is an invalid theme" unless Utils::Prism.themes[theme]
      theme
    end

    parameter '<input.md>', 'the path to the markdown file to convert', :attribute_name => :input
    parameter '<output.html>', 'the path to the outputted html file', :attribute_name => :output

    def execute
      Converter.convert(input, options)
    end

    private

    def options
      ConvertOptions.new(output, highlight?, theme)
    end
  end
end
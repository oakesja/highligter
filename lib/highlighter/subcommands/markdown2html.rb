require 'clamp'
require 'highlighter/converter'
require 'highlighter/convert_options'
require 'highlighter/utils/prism'

module Highlighter
  module Subcommands
    class Markdown2Html < Clamp::Command
      option '--[no-]highlight', :flag, 'highlight output or not', :default => true

      option %w(-t --theme), 'THEME', 'the THEME to use when highlighting',
             :attribute_name => :theme, :default => 'default' do |t|
        theme = t.strip.to_sym
        signal_usage_error "'#{t.strip}' is an invalid theme" unless Utils::Prism.themes[theme]
        theme
      end

      parameter '<input.md>', 'the markdown file to convert', :attribute_name => :input do |i|
        raise "'#{i}' does not exist for <input.md>" unless File.exist?(i)
        i
      end

      parameter '<output.html>', 'outputted html file', :attribute_name => :output do |o|
        dir = File.dirname(o)
        raise "The path '#{dir}' does not exist for <output.html>" unless File.directory?(dir)
        o
      end

      def execute
        Converter.markdown2html(input, options)
      end

      private

      def options
        ConvertOptions.new(output, highlight?, theme.to_sym)
      end
    end
  end
end
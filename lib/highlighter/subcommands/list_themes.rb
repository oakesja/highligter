require 'clamp'
require 'highlighter/utils/prism'

module Highlighter
  module Subcommands
    class ListThemes < Clamp::Command
      def execute
        Utils::Prism.themes.keys.each { |k| puts k }
      end
    end
  end
end
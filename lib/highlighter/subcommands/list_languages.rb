require 'clamp'
require 'highlighter/utils/prism'

module Highlighter
  module Subcommands
    class ListLanguages < Clamp::Command
      def execute
        langs = Utils::Prism.languages.values.collect(&:name).uniq.sort
        langs.each { |l| puts l }
      end
    end
  end
end
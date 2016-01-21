require 'spec_helper'
require 'highlighter/subcommands/list_themes'

module Highlighter
  module Subcommands
    describe ListThemes do
      subject { described_class.new(described_class.name) }

      describe '::run' do
        it 'outputs the available themes' do
          themes = Utils::Prism.themes.keys.collect(&:to_s).join("\n") + "\n"
          expect { subject.run([]) }.to output(themes).to_stdout
        end
      end
    end
  end
end
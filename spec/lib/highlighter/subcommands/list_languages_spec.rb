require 'spec_helper'
require 'highlighter/subcommands/list_languages'

module Highlighter
  module Subcommands
    describe ListLanguages do
      subject { described_class.new(described_class.name) }

      describe '::run' do
        it 'outputs the available languages' do
          langs = Utils::Prism.languages.values.collect(&:name).uniq.sort
          langs_string = langs.join("\n") + "\n"
          expect { subject.run([]) }.to output(langs_string).to_stdout
        end
      end
    end
  end
end
require 'spec_helper'
require 'highlighter/markdown'
require 'erb'

module Highlighter
  describe Markdown do
    describe '::to_html' do
      let(:options) { convert_options }
      it 'converts markdown input to html' do
        verify_to_html(Fixtures::Markdown.simple, Fixtures::Html.simple)
      end
      context 'for markdown with code blocks' do
        context 'and highlight code option is false' do
          let(:options) { convert_options(highlight: false) }
          it 'it does not add highlighting to code blocks' do
            verify_to_html(Fixtures::Markdown.code, Fixtures::Html.normal_code)
          end
        end
        context 'and highlight code option is true' do
          context 'and no theme was selected' do
            it 'it adds highlighting to code blocks with the default theme' do
              verify_to_html(Fixtures::Markdown.code, Fixtures::Html.highlighted_code_default)
            end
          end
          Utils::Prism.themes.each_key do |theme|
            context "and the #{theme} theme was selected" do
              let(:options) { convert_options(theme: theme) }
              it 'it adds highlighting to code blocks with the selected theme' do
                expected_fixture = "highlighted_code_#{theme.to_s}"
                verify_to_html(Fixtures::Markdown.code, Fixtures::Html.send(expected_fixture.to_sym))
              end
            end
          end
          Utils::Prism.languages.each_key do |language|
            context "and code block is written in #{language} " do
              it 'it adds highlighting to code blocks with the correct language syntax highlighting' do
                language_highlight_src = Utils::Prism.languages[language].js_url # used in binding for erb
                language_tag = Utils::Prism.languages[language].name # used in binding for erb
                markdown = ERB.new(read_fixture(Fixtures::Erb.code_markdown)).result(binding)
                html = ERB.new(read_fixture(Fixtures::Erb.code_html)).result(binding)
                expect(Markdown.new(options).to_html(markdown)).to eql html
              end
            end
          end
          context 'and there are multiple code blocks of the same language' do
            it 'will add the correct syntax highlighting only once' do
              verify_to_html(Fixtures::Markdown.multiple_code_same, Fixtures::Html.multiple_code_same)
            end
          end
          context 'and there are multiple code blocks of different languages' do
            it 'will add the correct syntax highlighting for all the languages' do
              verify_to_html(Fixtures::Markdown.multiple_code_different, Fixtures::Html.multiple_code_different)
            end
          end
        end
      end
    end

    def verify_to_html(input_file, output_file)
      html = Markdown.new(options).to_html(read_fixture(input_file))
      expect(html).to eql read_fixture(output_file)
    end

    def read_fixture(path)
      File.read(path)
    end


  end
end

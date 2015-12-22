require 'spec_helper'
require 'highlighter/convert_options'

module Highlighter
  describe Markdown do
    let(:options) { ConvertOptions.new }
    describe '::to_html' do
      it 'converts markdown input to html' do
        verify_to_html(Fixtures::Markdown.simple, Fixtures::Html.simple)
      end

      context 'for markdown with code blocks' do
        context 'and highlight code option is false' do
          it 'it does add highlighting to code blocks' do
            options.highlight_code = false
            verify_to_html(Fixtures::Markdown.code, Fixtures::Html.normal_code)
          end
        end
        context 'and highlight code option is true' do
          Utils::Prism.themes.each_key do |theme|
            context "and for the #{theme} theme" do
              it 'it adds highlighting to code blocks' do
                options.highlight_code = true
                options.theme = theme
                expected_with_theme = "highlighted_code_#{theme.to_s}"
                verify_to_html(Fixtures::Markdown.code, Fixtures::Html.send(expected_with_theme.to_sym))
              end
            end
          end
        end
      end

      def verify_to_html(input_file, output_file)
        html = Markdown.new(options).to_html(read_fixture(input_file))
        expect(html).to eql read_fixture(output_file)
      end
    end

    def read_fixture(path)
      File.read(path)
    end
  end
end

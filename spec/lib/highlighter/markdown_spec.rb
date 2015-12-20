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
          it 'it adds highlighting to code blocks' do
            options.highlight_code = true
            verify_to_html(Fixtures::Markdown.code, Fixtures::Html.highlighted_code)
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

require 'spec_helper'
require 'highlighter/cli'

describe 'integration' do
  let(:cli) { Highlighter::Cli.new('cli') }

  context 'when using markdown2htl' do
    let(:input) { Fixtures::Markdown.simple }
    let(:output) { 'output.html' }

    after(:each) do
      File.delete(output) if File.exist?(output)
    end

    it 'converts the inputted file to html' do
      cli.run(['markdown2html', input, output])
      expect(File.exist?(output)).to be true
      expected = File.read(Fixtures::Html.simple) + "\n"
      expect(File.read(output)).to eql expected
    end
  end
end
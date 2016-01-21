require 'spec_helper'
require 'highlighter/subcommands/markdown2html'

module Highlighter
  module Subcommands
    describe Markdown2Html do
      subject { described_class.new(described_class.name) }
      let(:input) { Fixtures::Markdown.simple }
      let(:output) { 'output.html' }

      describe '::run' do
        context 'when no input file is given' do
          it 'raises an error' do
            expect_run_error("parameter '<input.md>': no value provided")
          end
        end
        context 'when the input file does not exist' do
          it 'raise an error' do
            expect_run_error('/path', output, "'/path' does not exist for <input.md>")
          end
        end
        context 'when no output file is given' do
          it 'raises an error' do
            expect_run_error(input, "parameter '<output.html>': no value provided")
          end
        end
        context 'when the output path does not exist' do
          it 'raise an error' do
            expect_run_error(input, '/path/output.md', "The path '/path' does not exist for <output.html>")
          end
        end
        context 'when both an input file and output file is given' do
          it 'converts the files to the given output file' do
            expect_run_with_options(input, convert_options(output_path: output))
          end
        end

        context 'for the highlight flag' do
          context 'when the flag is not specified' do
            it 'default is true' do
              expect_run_with_options(input, convert_options(output_path: output, highlight: true))
            end
          end
          context 'when the highlight flag is specified' do
            it 'set highlight option to true' do
              expect_run_with_options('--highlight', input, convert_options(output_path: output, highlight: true))
            end
          end
          context 'when the no highlight flag is specified' do
            it 'set highlight option to false' do
              expect_run_with_options('--no-highlight', input, convert_options(output_path: output, highlight: false))
            end
          end
        end

        context 'for the theme option' do
          context 'when one is not specified' do
            it 'default the default theme' do
              expect_run_with_options(input, convert_options(output_path: output, theme: :default))
            end
          end
          context 'when one is specified' do
            it 'sets the theme to the one inputted' do
              ['-t dark', '--theme dark'].each do |args|
                expect_run_with_options(args, input, convert_options(output_path: output, theme: :dark))
              end
            end
            context 'and it not a valid theme' do
              it 'raises an error' do
                ['-t test', '--theme test'].each do |args|
                  expect_run_error_with_options(args, "'test' is an invalid theme")
                end
              end
            end
          end
        end
      end

      def expect_run_error(*args, error_msg)
        expect { subject.run(args) }.to raise_error error_msg
      end

      def expect_run_with_options(args='', input_file, options)
        expect(Converter).to receive(:convert).with(input_file, options)
        subject.run(create_args_with_options(args))
      end

      def expect_run_error_with_options(args='', error_msg)
        expect_run_error(*create_args_with_options(args), error_msg)
      end

      def create_args_with_options(opts)
        opts.split(' ') + [input, output]
      end
    end
  end
end
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift File.expand_path('../../spec', __FILE__)
require 'helpers/fixtures'
require 'highlighter/convert_options'

module Helpers
  def convert_options(output_path: '/path/to/output.html', highlight: true, theme: :default)
    Highlighter::ConvertOptions.new(output_path, highlight, theme)
  end
end

RSpec.configure do |c|
  c.include Helpers
end
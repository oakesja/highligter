require 'highlighter/utils/default_attributes'

module Highlighter
  class ConvertOptions
    extend Utils::DefaultAttributes

    accessor_with_default :output_path
    accessor_with_default :highlight_code,    true
    accessor_with_default :theme,             :default
    accessor_with_default :highlight_lines
    accessor_with_default :line_numbers,      false
    accessor_with_default :show_language,     false
  end
end
require 'highlighter/utils/default_attributes'

module Highlighter
  class ConvertOptions
    extend Utils::DefaultAttributes

    accessor_with_default :output_path
    accessor_with_default :highlight_code, true
  end
end
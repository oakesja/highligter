require 'redcarpet'
require 'highlighter/prism_code_renderer'

module Highlighter
  class Markdown
    def initialize(options)
      @options = options
    end

    def to_html(text)
      renderer = PrismCodeRenderer.new(@options.highlight_code, @options.theme)
      markdown = Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)
      markdown.render(text)
    end
  end
end

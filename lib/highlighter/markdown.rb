require 'redcarpet'

module Highlighter
  class Markdown
    def initialize(options)

    end

    def to_html(text)
      Redcarpet::Markdown.new(Redcarpet::Render::HTML.new).render(text)
    end
  end
end

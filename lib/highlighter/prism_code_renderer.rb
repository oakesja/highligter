require 'redcarpet'
require 'highlighter/utils/prism'

module Highlighter
  class Markdown
    class PrismCodeRenderer < Redcarpet::Render::HTML
      def initialize(highlight_code, theme)
        @highlight_code = highlight_code
        @theme = theme
        @languages = []
        super({})
      end

      def block_code(code, language)
        if @highlight_code
          @languages << language
          code_block_formatted(code, language)
        else
          code_block_formatted(code)
        end
      end

      def codespan(code)
        block_code(code, nil)
      end

      def postprocess(full_document)
        any_postprocessing? ? postprocess_document(full_document) : full_document
      end

      private

      def code_block_formatted(code, language=nil)
        clazz = language ? " class=\"language-#{language}\"" : ''
        "<pre><code#{clazz}>\n#{code}</code></pre>"
      end

      def any_postprocessing?
        @highlight_code && @languages.any?
      end

      def postprocess_document(full_document)
        scripts + full_document
      end

      def scripts
        main = script_tag(Highlighter::Utils::Prism.prismjs)
        langs = @languages.collect do |l|
          script_tag(Highlighter::Utils::Prism.languages[l])
        end
        theme = style_link(Highlighter::Utils::Prism.themes[@theme])
        [main, langs, theme].join("\n") + "\n"
      end

      def script_tag(url)
        "<script src=\"#{url}\"></script>"
      end

      def style_link(url)
        "<link rel=\"stylesheet\" href=\"#{url}\">"
      end
    end
  end
end
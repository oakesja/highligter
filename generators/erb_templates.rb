require_relative 'code_templates'

class ErbTemplates
  class << self
    def code_html(main_js, theme_url)
      ["<script src=\"#{main_js}\"></script>",
       '<script src="<%= language_highlight_src %>"></script>',
       "<link rel=\"stylesheet\" href=\"#{theme_url}\">",
       '<pre><code class="language-<%= language_tag %>">'] +
          CodeTemplates.simple_sample +
          ['</code></pre>']
    end

    def code_md
      ['```<%= language %>', CodeTemplates.simple_sample, '```' ''].flatten
    end
  end
end
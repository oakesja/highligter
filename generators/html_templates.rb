require_relative 'code_templates'

class HtmlTemplates
  class << self
    def theme(main_js, ruby_lang_url, theme_url)
      ["<script src=\"#{main_js}\"></script>",
       "<script src=\"#{ruby_lang_url}\"></script>",
       "<link rel=\"stylesheet\" href=\"#{theme_url}\">",
       '<pre><code class="language-ruby">'] +
          CodeTemplates.ruby_code_sample +
          ['</code></pre>']
    end

    def normal_code
      ['<pre><code>'] + CodeTemplates.ruby_code_sample + ['</code></pre>']
    end

    def simple
      ['<h1>Header 1</h1>', '', '<p>test</p>']
    end
  end
end
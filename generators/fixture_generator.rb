require_relative 'html_templates'
require_relative 'markdown_templates'

class FixtureGenerator
  def initialize(mainjs, language_lookup, theme_lookup)
    @mainjs = mainjs
    @language_lookup = language_lookup
    @theme_lookup = theme_lookup
  end

  def generate_html(base_dir)
    generate_code_themes_html(base_dir)
    %w(normal_code simple).each do |x|
      file = File.join(base_dir, x + '.html')
      write_lines_to(file, HtmlTemplates.send(x.to_sym))
    end
  end

  def generate_markdown(base_dir)
    %w(code simple).each do |x|
      file = File.join(base_dir, x + '.md')
      write_lines_to(file, MarkdownTemplates.send(x.to_sym))
    end
  end

  private

  def generate_code_themes_html(base_dir)
    @theme_lookup.each do |theme, url|
      file = File.join(base_dir, "highlighted_code_#{theme.to_s}.html")
      write_lines_to(file, HtmlTemplates.theme(@mainjs, @language_lookup[:ruby], url))
    end
  end

  def write_lines_to(file_path, lines)
    File.open(file_path, 'w') do |f|
      f.print lines.join("\n")
    end
  end
end
require_relative 'html_templates'
require_relative 'markdown_templates'
require_relative 'erb_templates'

class FixtureGenerator
  def initialize(prism_js_url, language_lookup, theme_lookup)
    @prism_js_url = prism_js_url
    @language_lookup = language_lookup
    @theme_lookup = theme_lookup
  end

  def generate_fixtures(base_dir)
    generate_html(File.join(base_dir, 'html'))
    generate_markdown(File.join(base_dir, 'markdown'))
    generate_erb(File.join(base_dir, 'erb'))
  end

  private

  def generate_html(base_dir)
    generate_from_templates(base_dir, %w(normal_code simple), '.html', HtmlTemplates)
    generate_code_themes_html(base_dir)
  end

  def generate_markdown(base_dir)
    names = %w(code multiple_code_different multiple_code_same simple)
    generate_from_templates(base_dir, names, '.md', MarkdownTemplates)
  end

  def generate_code_themes_html(base_dir)
    @theme_lookup.each do |theme, url|
      file = File.join(base_dir, "highlighted_code_#{theme.to_s}.html")
      write_lines_to(HtmlTemplates.theme(@prism_js_url, @language_lookup[:ruby], url), file)
    end
  end

  def generate_erb(base_dir)
    files = %w(code_html.erb code_markdown.erb)
    lines = [ErbTemplates.code_html(@prism_js_url, @theme_lookup[:default]), ErbTemplates.code_md]
    create_files(base_dir, files, lines)
  end

  def generate_from_templates(base_dir, names, files_extension, templates)
    files = names.collect { |n| n + files_extension }
    lines = names.collect { |n| templates.send(n.to_sym) }
    create_files(base_dir, files, lines)
  end

  def create_files(base_dir, file_names, file_lines)
    file_names = file_names.collect { |f| File.join(base_dir, f) }
    file_names.zip(file_lines) do |path, lines|
      write_lines_to(lines, path)
    end
  end

  def write_lines_to(lines, file_path)
    File.open(file_path, 'w') do |f|
      f.print lines.join("\n")
    end
  end
end
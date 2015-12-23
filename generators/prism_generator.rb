class PrismGenerator
  TAB = '  '

  def initialize(main_js, language_lookup, theme_lookup)
    @main_js = main_js
    @language_lookup = language_lookup
    @theme_lookup = theme_lookup
  end

  def generate_prism_class(file_path)
    File.open(file_path, 'w') do |f|
      f.puts 'module Highlighter'
      f.puts with_tabs 'module Utils', 1
      f.puts with_tabs 'class Prism', 2
      f.puts with_tabs 'class << self', 3
      generate_methods(f, 4)
      f.puts with_tabs 'end', 3
      f.puts with_tabs 'end', 2
      f.puts with_tabs 'end', 1
      f.puts 'end'
    end
  end

  private

  def generate_methods(f, starting_tab)
    f.puts with_tabs 'def prismjs', starting_tab
    f.puts with_tabs "'#{@main_js}'", starting_tab + 1
    f.puts with_tabs 'end', starting_tab
    f.puts
    generate_hash_method(f, 'themes', @theme_lookup, starting_tab)
    f.puts
    generate_hash_method(f, 'languages', @language_lookup, starting_tab)
  end

  def with_tabs(output, num_tabs)
    TAB*num_tabs + output
  end

  def generate_hash_method(f, name, hash_lookup, starting_tab)
    f.puts with_tabs "def #{name}", starting_tab
    f.puts with_tabs '{', starting_tab + 1
    hash_lookup.each do |k, v|
      f.puts with_tabs "#{k}: '#{v}',", starting_tab + 2
    end
    f.puts with_tabs '}', starting_tab + 1
    f.puts with_tabs 'end', starting_tab
  end
end
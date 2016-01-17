require 'yaml'
require 'net/http'
require_relative 'file_utils'

class PrismGenerator
  include FileUtils

  GITHUB_LANGUAGES_URL = 'https://raw.githubusercontent.com/github/linguist/master/lib/linguist/languages.yml'

  def initialize(prism_js_url, language_lookup, theme_lookup, plugin_lookup)
    @prism_js_url = prism_js_url
    @language_lookup = create_lang_lookup_with_aliases(language_lookup)
    @theme_lookup = theme_lookup
    @plugin_lookup = plugin_lookup
  end

  def generate_prism_class(file_path)
    File.open(file_path, 'w') do |f|
      f.puts 'module Highlighter'
      f.puts with_tabs 'module Utils', 1
      f.puts with_tabs 'class Prism', 2
      f.puts with_tabs 'class << self', 3
      f.puts with_tabs 'Language = Struct.new(:name, :js_url)', 4
      f.puts
      generate_methods(f, 4)
      f.puts with_tabs 'end', 3
      f.puts with_tabs 'end', 2
      f.puts with_tabs 'end', 1
      f.puts 'end'
    end
  end

  private

  def create_lang_lookup_with_aliases(language_lookup)
    lookup = {}
    language_lookup.each do |lang, url|
      aliases = find_aliases_for(lang)
      aliases.delete_if { |a| a.include?(' ') }
      aliases.each do |a|
        lookup[a.to_sym] = "Language.new('#{lang}', '#{url}')"
      end
    end
    lookup
  end

  def find_aliases_for(language)
    lang = all_languages.find do |k, v|
      aliases = [k, k.downcase, v['aliases']].flatten.compact
      aliases.include?(language.to_s)
    end
    if lang
      name = lang[0]
      attrs = lang[1]
      [name, name.downcase, attrs['aliases']].flatten.compact
    else
      []
    end
  end

  def all_languages
    @all_langs ||= YAML.load(Net::HTTP.get(URI(GITHUB_LANGUAGES_URL)))
  end

  def generate_methods(f, starting_tab)
    f.puts with_tabs 'def prismjs', starting_tab
    f.puts with_tabs "'#{@prism_js_url}'", starting_tab + 1
    f.puts with_tabs 'end', starting_tab
    f.puts
    generate_hash_method(f, 'themes', @theme_lookup, starting_tab)
    f.puts
    generate_hash_method(f, 'languages', @language_lookup, starting_tab, string_keys: true, string_values: false)
    f.puts
    generate_hash_method(f, 'plugins', @plugin_lookup, starting_tab)
  end

  def generate_hash_method(f, name, hash_lookup, starting_tab, string_keys: false, string_values: true)
    f.puts with_tabs "def #{name}", starting_tab
    f.puts with_tabs '{', starting_tab + 1
    hash_lookup.each do |k, v|
      key = string_keys ? "'#{k}' => " : "#{k}: "
      value = string_values ? "'#{v}'," : "#{v},"
      key_value = key + value
      f.puts with_tabs key_value, starting_tab + 2
    end
    f.puts with_tabs '}', starting_tab + 1
    f.puts with_tabs 'end', starting_tab
  end
end
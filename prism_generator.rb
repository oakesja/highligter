require 'net/http'
require 'oj'

class PrismGenerator
  JSDELIVER_API_ROUTE = 'https://api.jsdelivr.com/v1/jsdelivr/libraries?name=prism'
  TAB = '  '
  ASSET_BASE_URI = 'https://cdn.jsdelivr.net/prism'

  def generate_class(file_path)
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
    f.puts with_tabs "'#{asset_link('prism.js')}'", starting_tab + 1
    f.puts with_tabs 'end', starting_tab
    f.puts
    generate_hash_method(f, 'themes', theme_lookup, starting_tab)
    f.puts
    generate_hash_method(f, 'languages', component_lookup, starting_tab)
  end

  def generate_hash_method(f, name, hash_lookup, starting_tab)
    f.puts with_tabs "def #{name}", starting_tab
    f.puts with_tabs '{', starting_tab + 1
    hash_lookup.each do |k, v|
      f.puts with_tabs "#{k}: '#{asset_link(v)}',", starting_tab + 2
    end
    f.puts with_tabs '}', starting_tab + 1
    f.puts with_tabs 'end', starting_tab
  end

  def asset_link(asset)
    "#{ASSET_BASE_URI}/#{@latest_version}/#{asset}"
  end

  def with_tabs(output, num_tabs)
    TAB*num_tabs + output
  end

  def theme_lookup
    create_lookup_for(themes, 'themes\/prism-')
  end

  def component_lookup
    create_lookup_for(components, 'components\/prism-')
  end

  def create_lookup_for(items, suffix)
    lookup = items.collect do |t|
      match_data = t.match(/#{suffix}(\w*)/)
      if match_data
        [match_data[1].to_sym, t]
      else
        [:main, t]
      end
    end
    Hash[lookup]
  end

  def themes
    all_files_that_start_with('themes')
  end

  def plugins
    all_files_that_start_with('plugins')
  end

  def components
    all_files_that_start_with('components')
  end

  def all_files_that_start_with(suffix)
    latest_version_files.find_all do |f|
      f.start_with?(suffix)
    end
  end

  def latest_version_files
    @files ||= get_latest_version_files
  end

  def get_latest_version_files
    uri = URI(JSDELIVER_API_ROUTE)
    results = Oj.load(Net::HTTP.get(uri)).first
    @latest_version = results['lastversion']
    lastest_assets = results['assets'].find do |a|
      a['version'] == @latest_version
    end
    lastest_assets['files']
  end
end

base_dir = File.dirname(__FILE__)
class_path = File.join(base_dir, 'lib', 'highlighter', 'utils', 'prism.rb')
generator = PrismGenerator.new
generator.generate_class(class_path)
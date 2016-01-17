require 'net/http'
require 'oj'
require_relative 'prism_generator'
require_relative 'fixture_generator.rb'

class AssetGenerator
  JSDELIVER_API_ROUTE = 'https://api.jsdelivr.com/v1/jsdelivr/libraries?name=prism'
  ASSET_BASE_URI = 'https://cdn.jsdelivr.net/prism'

  def initialize
    @files = get_latest_version_files
    @prism_js_url = asset_link('prism.js')
    @theme_lookup = create_lookup_for(themes, 'themes\/prism-', '\.')
    @language_lookup = create_lookup_for(components, 'components\/prism-', '\.min')
    @plugin_lookup = create_lookup_for(plugins, 'plugins\/', '\/')
  end

  def generate_prism_class(file_path)
    generator = PrismGenerator.new(@prism_js_url, @language_lookup, @theme_lookup, @plugin_lookup)
    generator.generate_prism_class(file_path)
  end

  def generate_fixtures(fixture_dir, fixture_helper_path)
    generator = FixtureGenerator.new(@prism_js_url, @language_lookup, @theme_lookup)
    generator.generate_fixtures(fixture_dir)
  end

  private

  def asset_link(asset)
    "#{ASSET_BASE_URI}/#{@latest_version}/#{asset}"
  end

  def create_lookup_for(items, filename_prefix, filename_suffix)
    lookup = items.collect do |t|
      match_data = t.match(/#{filename_prefix}(\S*)#{filename_suffix}/)
      url = asset_link(t)
      if match_data
        [match_data[1].gsub('-', '_').to_sym, url]
      else
        [:default, url]
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

  def all_files_that_start_with(filename_suffix)
    @files.find_all { |f| f.start_with?(filename_suffix) }
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
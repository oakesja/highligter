require_relative 'generators/asset_generator'

base_dir = File.absolute_path('../', __FILE__)
class_path = File.join(base_dir, 'lib', 'highlighter', 'utils', 'prism.rb')
fixture_path = File.join(base_dir, 'spec', 'fixtures')
fixture_helper = File.join(base_dir, 'spec', 'helpers', 'fixtures.rb')
generator = AssetGenerator.new
generator.generate_prism_class(class_path)
generator.generate_fixtures(fixture_path, fixture_helper)
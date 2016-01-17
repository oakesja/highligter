class FixtureHelperGenerator
  class << self
    include FileUtils

    def generate(file_path, fixture_dir)
      File.open(file_path, 'w') do |f|
        f.puts "require 'helpers/fixture_utils'"
        f.puts
        f.puts 'class Fixtures'
        generate_fixture_helpers(f, fixture_dir, 1)
        f.puts 'end'
      end
    end

    private
    def generate_fixture_helpers(file, fixture_dir, starting_tab)
      dirs = Dir.glob(fixture_dir + '/*')
      dirs.each do |d|
        name = File.basename(d)
        files = Dir.glob(d + '/*')
        ext = File.extname(files.first)
        file_names = files.collect { |f| File.basename(f, '.*') }
        write_fixture_helpers(file, name, ext, file_names, starting_tab)
      end
    end

    def write_fixture_helpers(file, name, ext, file_names, starting_tab)
      file.puts with_tabs "class #{name.downcase.capitalize}", starting_tab
      file.puts with_tabs 'class << self', starting_tab + 1
      file.puts with_tabs 'extend FixtureUtils', starting_tab + 2
      file.puts with_tabs "fixture_info '#{name.downcase}', '#{ext}'", starting_tab + 2
      file.puts
      file_names.each do |fn|
        file.puts with_tabs "fixture '#{fn}'", starting_tab + 2
      end
      file.puts with_tabs 'end', starting_tab + 1
      file.puts with_tabs 'end', starting_tab
    end
  end
end
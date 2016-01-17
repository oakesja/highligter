module FixtureUtils
  def fixture_info(subdir, file_ext)
    path_method_name = "#{subdir}_path"
    define_method(:path_method) do
      path_method_name
    end
    define_method(path_method_name) do |filename|
      base_dir = File.absolute_path('spec/fixtures')
      rel_file_path = File.join(subdir, filename + file_ext)
      File.join(base_dir, rel_file_path)
    end
  end

  def fixture(filename)
    define_method(filename) do
      send(path_method, filename)
    end
  end
end

class Fixtures
  module Helpers
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

  class Markdown
    class << self
      extend Helpers
      fixture_info 'markdown', '.md'

      fixture 'simple'
      fixture 'code'
    end
  end

  class Html
    class << self
      extend Helpers
      fixture_info 'html', '.html'

      fixture 'simple'
      fixture 'normal_code'
      fixture 'highlighted_code_coy'
      fixture 'highlighted_code_dark'
      fixture 'highlighted_code_default'
      fixture 'highlighted_code_funky'
      fixture 'highlighted_code_okaidia'
      fixture 'highlighted_code_tomorrow'
      fixture 'highlighted_code_twilight'
    end
  end

  class Erb
    class << self
      extend Helpers
      fixture_info 'erb', '.erb'

      fixture 'code_html'
      fixture 'code_markdown'
    end
  end
end
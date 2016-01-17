require 'helpers/fixture_utils'

class Fixtures
  class Erb
    class << self
      extend FixtureUtils
      fixture_info 'erb', '.erb'

      fixture 'code_html'
      fixture 'code_markdown'
    end
  end
  class Markdown
    class << self
      extend FixtureUtils
      fixture_info 'markdown', '.md'

      fixture 'multiple_code_different'
      fixture 'multiple_code_same'
      fixture 'code'
      fixture 'simple'
    end
  end
  class Html
    class << self
      extend FixtureUtils
      fixture_info 'html', '.html'

      fixture 'highlighted_code_funky'
      fixture 'highlighted_code_dark'
      fixture 'multiple_code_different'
      fixture 'highlighted_code_okaidia'
      fixture 'normal_code'
      fixture 'highlighted_code_default'
      fixture 'highlighted_code_coy'
      fixture 'multiple_code_same'
      fixture 'highlighted_code_tomorrow'
      fixture 'simple'
      fixture 'highlighted_code_twilight'
    end
  end
end

class MarkdownTemplates
  class << self
    def code
      ['```ruby'] + CodeTemplates.ruby_code_sample + ['```']
    end

    def simple
      ['# Header 1', 'test']
    end

    def multiple_code_different
      code + ['```java', 'int x = 1', '```']
    end

    def multiple_code_same
      code + ['```jruby', 'x = 1', '```']
    end
  end
end
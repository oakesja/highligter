class MarkdownTemplates
  class << self
    def code
      ['```ruby'] + CodeTemplates.ruby_code_sample + ['```']
    end

    def simple
      ['# Header 1', 'test']
    end
  end
end
class CodeTemplates
  class << self
    def ruby_code_sample
      ['Class Foo',
       '  def bar(x)',
       '    # your code goes here',
       '  end',
       'end']
    end

    def simple_sample
      ['x = 1']
    end
  end
end
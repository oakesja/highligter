require 'spec_helper'
require 'highlighter/utils/default_attributes'

module Highlighter
  module Utils
    class TestWithDefault < DefaultAttributes
      accessor_with_default :x, 1
    end

    class TestWithOutDefault < DefaultAttributes
      accessor_with_default :x
    end

    describe DefaultAttributes do
      describe '::accessor_with_default' do
        context 'when a default is specified' do
          it 'the attribute will have that value' do
            test = TestWithDefault.new
            expect(test.instance_variables).to eql %i(@x)
            expect(test.x).to eql 1
            test.x = 2
            expect(test.x).to eql 2
          end
        end

        context 'when a default is not specified' do
          it 'the attribute will have that value' do
            test = TestWithOutDefault.new
            expect(test.instance_variables).to eql %i(@x)
            expect(test.x).to eql nil
            test.x = 2
            expect(test.x).to eql 2
          end
        end
      end
    end
  end
end


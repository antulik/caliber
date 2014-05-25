require 'spec_helper'
require 'caliber/nested_parser'

describe Caliber::NestedParser do

  describe 'parse line' do

    it 'parses class with dash' do
      np = Caliber::NestedParser.new []

      np.parse_line('.nav-pills').must_equal ['.nav', '-pills']
      np.parse_line('#nav .pills').must_equal ['#nav', ' .pills']
      np.parse_line('#nav.pills').must_equal ['#nav', '.pills']
    end
  end

  describe 'parse' do
    nav = [
      '.nav',
      '.nav-pills',
      '.nav .active',
      '.nav.nav-pills',
    ]

    it 'bootstrap nav class css' do
      np = Caliber::NestedParser.new nav

      result = np.parse
      result.must_equal(
        '.nav' => {
          '-pills' => {},
          ' .active' => {},
          '.nav' => {
            '-pills' => {}
          },
        }
      )
    end
  end
end

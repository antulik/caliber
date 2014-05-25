require 'spec_helper'
require 'caliber/nested_parser_character'

describe Caliber::NestedParserCharacter do

  describe 'group_by_char' do


    it 'generates hash sliced by character' do
      list = [
        {selector: 'a'},
        {selector: 'abc'},
        {selector: 'a bc'},
        {selector: 'a .b'},
        {selector: 'a-bc'},
        {selector: 'bc'},
      ]

      np = Caliber::NestedParserCharacter.new

      r = np.group_by_char list
      r.must_include 'a', 'b'

      r['a'].must_include 'b'
      r['a'].must_include ' '
      r['a'].must_include '-'

      r['a']['b'].must_include 'c'

      r['a'][' '].must_include 'b'
      r['a'][' '].must_include '.'
    end
  end

  describe 'merge_nested' do
    it 'merges hash' do
      np = Caliber::NestedParserCharacter.new

      r = np.merge_nested(
        'a' => {
          'b' => {
            'c' => {},
            '-' => {},
          }
        }
      )

      r.must_equal(
        'ab' => {
          'c' => {},
          '-' => {},
        }
      )
    end

  end
end

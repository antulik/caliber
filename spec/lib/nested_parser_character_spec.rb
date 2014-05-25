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
    it 'merges separate buckets' do
      np = Caliber::NestedParserCharacter.new

      r = np.merge_nested(
        'a' => {
          'b' => {
            'c' => {
              'd' => []
            },
          }
        },
        '1' => {
          '2' => []
        }
      )

      r.must_equal(
        'abcd' => [],
        '12' => []
      )
    end

    it 'merges four levels' do
      np = Caliber::NestedParserCharacter.new

      r = np.merge_nested(
        'a' => {
          'b' => {
            'c' => {
              'd' => []
            },
          }
        }
      )

      r.must_equal(
        'abcd' => []
      )
    end

    it 'merges three levels' do
      np = Caliber::NestedParserCharacter.new

      r = np.merge_nested(
        'a' => {
          'b' => {
            'c' => [],
          }
        }
      )

      r.must_equal(
        'abc' => []
      )
    end

    it 'merges two levels' do
      np = Caliber::NestedParserCharacter.new

      r = np.merge_nested(
        "ab" => {
          "c" => []
        }
      )

      r.must_equal(
        'abc' => []
      )
    end

    it 'merges single level' do
      np = Caliber::NestedParserCharacter.new

      r = np.merge_nested(
        "abc" => []
      )

      r.must_equal(
        'abc' => []
      )
    end

    # it 'merges complex objects' do
    #   obj =  [
    #     {
    #       pathname: "/Users/anton/work/opensight/app/assets/stylesheets/application.scss",
    #       selector: ".d:bef",
    #       declarations: "content: '';<br> display: inline-block;<br> border-left: 7px solid transparent;<br> border-right: 7px solid transparent;<br> border-bottom: 7px solid #ccc;<br> border-bottom-color: rgba(0, 0, 0, 0.2);<br> position: absolute;<br> top: -7px;<br> left: 6px;<br>",
    #       specificity: 11,
    #       media_types: [
    #         "all"
    #       ]
    #     },
    #     {
    #       pathname: "/Users/anton/work/opensight/app/assets/stylesheets/application.scss",
    #       selector: ".d:aft",
    #       declarations: "content: '';<br> display: inline-block;<br> border-left: 6px solid transparent;<br> border-right: 6px solid transparent;<br> border-bottom: 6px solid #ffffff;<br> position: absolute;<br> top: -6px;<br> left: 7px;<br>",
    #       specificity: 11,
    #       media_types: [
    #         "all"
    #       ]
    #     }
    #   ]
    #
    #   np = Caliber::NestedParserCharacter.new
    #
    #   r = np.group_by_char obj
    #   r = np.merge_nested r
    #
    #
    #   r.must_include '.datepicker'
    # end

  end
end

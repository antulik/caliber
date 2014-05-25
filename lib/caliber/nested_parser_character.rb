module Caliber
  class NestedParserCharacter


    def initialize
    end

    def parse list
      hash = group_by_char list
      merge_nested hash
    end

    def group_by_char list, char_index = 0
      current_level = list.delete_if do |item|
        item[:selector].length <= char_index
      end

      grouped = list.group_by do |item|
        item[:selector][char_index]
      end

      grouped.each_key do |char|
        group_list = grouped[char]
        grouped[char] = group_by_char group_list, char_index + 1
      end

      grouped[:items] = current_level
      grouped
    end

    def merge_nested hash
      return hash if hash.is_a? Array

      if hash.size == 1
        orig = hash
        k = orig.keys.first
        v = orig.values.first

        if v.is_a? Array
          return v
        end

        hash = {}
        v.each_key do |key|
          hash["#{k}#{key}"] = v[key]
        end
      end

      hash.each_key do |key|
        hash[key] = merge_nested hash[key]
      end
      hash

    end

  end
end

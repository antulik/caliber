module Caliber
  class NestedParserCharacter


    def initialize
    end

    def parse list
      hash = group_by_char list
      merge_nested hash
    end

    def group_by_char list, char_index = 0
      deleted_items = []
      list.delete_if do |item|
        r = item[:selector].length <= char_index
        deleted_items << item if r
        r
      end

      grouped = list.group_by do |item|
        item[:selector][char_index]
      end

      grouped.each_key do |char|
        group_list = grouped[char]
        grouped[char] = group_by_char group_list, char_index + 1
      end

      grouped['items'] = deleted_items if deleted_items.size > 0
      grouped
    end

    # {
    #   a: {
    #     b: {
    #       c: []
    #     },
    #     1: {
    #       2: []
    #     }
    #   }
    # }
    #
    # returns
    # {
    #   abc: []
    # }
    def merge_nested hash
      new_hash = {}

      flag = false
      hash.each_key do |k|
        v = hash[k]

        if v.is_a? Array
          new_hash[k] = v
        elsif v.size == 1 && !v.keys.include?('items')
          v.each_key do |key|
            new_hash["#{k}#{key}"] = v[key]
          end
          flag = true
        else
          new_hash[k] = merge_nested v
        end

      end

      if flag
        merge_nested new_hash
      else
        new_hash
      end
    end

    def two

      if hash.size == 1 || (hash.size == 2 && hash.include?('items'))
        orig = hash
        k = orig.keys.first
        v = orig.values.first

        if v.is_a? Array
          return hash
        end

        hash = {}
        v.each_key do |key|
          if key == 'items'
            hash[key] = v[key]
          else
            hash["#{k}#{key}"] = v[key]
          end
        end
        return merge_nested hash
      end


      hash.each_key do |key|
        if key == 'items'
          next
        elsif hash[key].is_a? Array
          hash[key] = hash[key]
        else
          hash[key] = merge_nested hash[key]
        end
      end

      hash
    end

  end
end

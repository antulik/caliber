module Caliber
  class NestedParser3

    def parse_selector selector
      selector.scan /.[^- :.]*/
    end

    def parse list
      list.each do |item|
        item[:keys] = parse_selector item[:selector]
      end

      h = group_by list
      h = merge_nested h
    end

    def group_by list
      h = {}

      list.each do |item|
        tmp = h
        item[:keys].each do |key|
          tmp[key] ||= {}

          tmp = tmp[key]
        end

        tmp['&'] ||= []
        tmp['&'].push item
      end

      h
    end

    def merge_nested hash
      new_hash = {}

      flag = false
      hash.each_key do |k|
        v = hash[k]

        if v.is_a? Array
          new_hash[k] = v
        elsif v.size == 1 && !v.keys.include?('&')
          v.each_key do |key|
            new_hash["#{k}#{key}"] = v[key]
          end
          flag = true
        elsif v.size == 1 && v.keys.include?('&')
          new_hash[k] = v.values.first
          # raise
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

  end
end

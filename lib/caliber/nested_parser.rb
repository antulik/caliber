module Caliber
  class NestedParser

    attr_reader :list

    def initialize list
      @list = list
    end

    def parse_line line
      line.scan /..[^- :.]+/
    end

    def parse
      tokens = list.map do |item|
        parse_line item
      end

      group_by_nested tokens
    end

    def group_by_nested tokens
      tokens.delete_if { |item| item.empty? }
      return {} if tokens.empty?

      result = tokens.group_by do |list|
        list.first
      end

      result.keys.each do |key|
        group = result[key]
        group.each do |item|
          item.shift
        end

        result[key] = group_by_nested group
      end

      result
    end

  end
end
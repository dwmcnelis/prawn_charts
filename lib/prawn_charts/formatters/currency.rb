
require 'prawn_charts/formatters/formatter'

module PrawnCharts
  module Formatters

    # Currency formatter.
    #
    # Provides formatting for currencies.
    class Currency < Formatter

      # Returns a new Currency class.
      #
      # Options:
      # precision:: precision of value
      # unit:: Defaults to '$'
      # separator:: Defaults to '.'
      # delimiter:: Defaults to ','
      # negative_color:: Color of value marker for negative values.  Defaults to 'red'
      # special_negatives:: If set to true, parenthesizes negative numbers.  ie:  -$150.50 becomes ($150.50).
      #                     Defaults to false.
      def initialize(options = {})
        @precision        = options[:precision] || 2
        @unit             = options[:unit] || '$'
        @separator        = options[:separator] || '.'
        @delimiter        = options[:delimiter] || ','
        @negative_color   = options[:negative_color] || 'red'
        @special_negatives = options[:special_negatives] || false
      end

      # Formats value marker.
      def format(target, idx, options)
        @separator = "" unless @precision > 0
        begin
          parts = number_with_precision(target, @precision).split('.')
          if @special_negatives && (target.to_f < 0)
            number = "(" + @unit + parts[0].to_i.abs.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{@delimiter}") + @separator + parts[1].to_s + ")"
          else
            number = @unit + parts[0].to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{@delimiter}") + @separator + parts[1].to_s
            number.gsub!(@unit + '-', '-' + @unit)
          end
          if (target.to_f < 0) && @negative_color
            options[:marker_color_override] = @negative_color
          else
            options[:marker_color_override] = nil
          end
          number
        rescue
          target
        end
      end
    end # Currency

  end # Formatters
end # PrawnCharts
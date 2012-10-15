
require 'prawn_charts/formatters/formatter'

module PrawnCharts
  module Formatters

    # Default date formatter.
    class Date < Formatter

      def initialize(format_string, options = {})
        @format_string = format_string
      end

      # Formats percentages.
      def format(target, idx, options)
        begin
          target.strftime(@format_string)
        rescue
          target
        end
      end
    end # Date

  end # Formatters
end # PrawnCharts
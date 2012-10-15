
require 'prawn_charts/formatters/formatter'

module PrawnCharts
  module Formatters

    # Percentage formatter.
    #
    # Provides formatting for percentages.
    class Percentage < Formatter

      # Returns new Percentage formatter.
      #
      # Options:
      # precision:: Defaults to 3.
      # separator:: Defaults to '.'
      def initialize(options = {})
        @precision    = options[:precision] || 3
        @separator    = options[:separator] || '.'
      end

      # Formats percentages.
      def format(target)
        begin
          number = number_with_precision(target, @precision)
          parts = number.split('.')
          if parts.at(1).nil?
            parts[0] + "%"
          else
            parts[0] + @separator + parts[1].to_s + "%"
          end
        rescue
          target
        end
      end
    end # Percentage

  end # Formatters
end # PrawnCharts

require 'prawn_charts/formatters/formatter'

module PrawnCharts
  module Formatters

    # Allows you to pass in a Proc for use as a formatter.
    #
    # Use:
    #
    # graph.value_formatter = PrawnCharts::Formatters::Custom.new { |value, idx, options| "Displays Returned Value" }
    class Custom < Formatter
      attr_reader :proc

      def initialize(&block)
        @proc = block
      end

      def format(target, idx, options)
        proc.call(target, idx, options)
      end
    end # Custom

  end # Formatters
end # PrawnCharts
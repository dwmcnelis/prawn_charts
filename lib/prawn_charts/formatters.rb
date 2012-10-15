
require 'prawn_charts/formatters/formatter'
require 'prawn_charts/formatters/currency'
require 'prawn_charts/formatters/custom'
require 'prawn_charts/formatters/date'
require 'prawn_charts/formatters/number'
require 'prawn_charts/formatters/percentage'

# Formatters are used to format the values displayed on the y-axis by
# setting graph.value_formatter.
#
# Example:
#
#   graph.value_formatter = PrawnCharts::Formatters::Currency.new(:precision => 0)
#
module PrawnCharts
  module Formatters
  end # Formatters
end # PrawnCharts
# Formatters are used to format the values displayed on the y-axis by
# setting graph.value_formatter.
#
# Example:
#
#   graph.value_formatter = PrawnCharts::Formatters::Currency.new(:precision => 0)
#
module PrawnCharts
  module Formatters

    # Formatters are used to format the values displayed on the y-axis by
    # setting graph.value_formatter.
    class Formatter

      # Called by the value marker component.  Routes the format call
      # to one of a couple possible methods.
      #
      # If the formatter defines a #format method, the returned value is used
      # as the value.  If the formatter defines a #format! method, the value passed is
      # expected to be modified, and is used as the value.  (This may not actually work,
      # in hindsight.)
      def route_format(target, idx, options = {})
        args = [target, idx, options]
        if respond_to?(:format)
          send :format, *args[0...self.method(:format).arity]
        elsif respond_to?(:format!)
          send :format!, *args[0...self.method(:format!).arity]
          target
        else
          raise NameError, "Formatter subclass must container either a format() method or format!() method."
        end
      end

      protected
      def number_with_precision(number, precision=3)  #:nodoc:
        sprintf("%01.#{precision}f", number)
      end
    end # Formatter

  end # Formatters
end # PrawnCharts
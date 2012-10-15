
require 'prawn_charts/formatters/formatter'

module PrawnCharts
  module Formatters

    # Default number formatter.
    # Limits precision, beautifies numbers.
    class Number < Formatter
      attr_accessor :precision, :separator, :delimiter, :precision_limit

      # Returns a new Number formatter.
      #
      # Options:
      # precision:: precision to use for value.  Can be set to an integer, :none or :auto.
      #             :auto will use whatever precision is necessary to portray all the numerical
      #             information, up to :precision_limit.
      #
      #             Example:  [100.1, 100.44, 200.323] will result in [100.100, 100.440, 200.323]
      #
      # separator:: decimal separator.  Defaults to '.'
      # delimiter:: delimiter character.  Defaults to ','
      # precision_limit:: upper limit for auto precision. (Ignored if roundup is specified)
      # roundup:: round up the number to the given interval
      def initialize(options = {})
        @precision        = options[:precision] || :none
        @roundup          = options[:roundup] || :none
        @separator        = options[:separator] || '.'
        @delimiter        = options[:delimiter] || ','
        @precision_limit  = options[:precision_limit] || 4
      end

      # Formats the value.
      def format(target, idx, options)
        my_precision = @precision

        if @precision == :auto
          my_precision = options[:all_values].inject(0) do |highest, current|
            cur = current.to_f.to_s.split(".").last.size
            cur > highest ? cur : highest
          end

          my_precision = @precision_limit if my_precision > @precision_limit
        elsif @precision == :none
          my_precision = 0
        end

        my_separator = @separator
        my_separator = "" unless my_precision > 0
        begin
          number = ""

          if @roundup == :none
            parts = number_with_precision(target, my_precision).split('.')
            number = parts[0].to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{@delimiter}") + my_separator + parts[1].to_s
          else
            number = roundup(target.to_f, @roundup).to_i.to_s
          end

          number
        rescue StandardError => e
          target
        end
      end


      def roundup(target, nearest=100)
        target % nearest == 0 ? target : target + nearest - (target % nearest)
      end
      def rounddown(target, nearest=100)
        target % nearest == 0 ? target : target - (target % nearest)
      end
    end # Number

  end # Formatters
end # PrawnCharts
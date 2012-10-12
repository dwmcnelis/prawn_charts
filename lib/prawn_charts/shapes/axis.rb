module PrawnCharts
  module Shapes

    # (adapted from prawn-shapes by Daniel Nelson)
    module Axis

      # Draws X and Y axis rulers beginning at the margin box origin. Used on
      # examples.
      #
      def axis(options={})
        options = { :height => (cursor - 20).to_i,
          :width => bounds.width.to_i
        }.merge(options)

        dash(1, :space => 4)
        stroke_horizontal_line(-21, options[:width], :at => 0)
        stroke_vertical_line(-21, options[:height], :at => 0)
        undash

        fill_circle [0, 0], 1

        (100..options[:width]).step(100) do |point|
          fill_circle [point, 0], 1
          draw_text point, :at => [point-5, -10], :size => 7
        end

        (100..options[:height]).step(100) do |point|
          fill_circle [0, point], 1
          draw_text point, :at => [-17, point-2], :size => 7
        end
      end

    end # Axis

  end # Shapes
end # PrawnCharts


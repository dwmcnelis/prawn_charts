module PrawnCharts
  module Shapes

    module CropMarks

      # Draws crop marks at each corner of a bounding box
      #
      def crop_marks(at,width,height)
        length = 10
        # upper left
        stroke_horizontal_line(at[0]-length,at[0],:at => at[1])
        stroke_vertical_line(at[1],at[1]+length,:at => at[0])
        # upper right
        stroke_horizontal_line(at[0]+width,at[0]+width+length,:at => at[1])
        stroke_vertical_line(at[1],at[1]+length,:at => at[0]+width)
        # lower right
        stroke_horizontal_line(at[0]+width,at[0]+width+length,:at => at[1]-height)
        stroke_vertical_line(at[1]-height,at[1]-height-length,:at => at[0]+width)
        # upper left
        stroke_horizontal_line(at[0]-length,at[0],:at => at[1]-height)
        stroke_vertical_line(at[1]-height,at[1]-height-length,:at => at[0])
        # dash bounds
        dash(1,:space => 4)
        stroke_rectangle(at,width,height)
        undash
      end

    end # CropMarks

  end # Shapes
end # PrawnCharts


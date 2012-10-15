
module PrawnCharts
  module Shapes

    # (adapted from prawn-shapes by Daniel Nelson)
    module Arc

      # options must include :radius and :side
      # side is either :left or :right
      # see pie_slice for explanation of optional
      # :stroke_both_sides option
      #
      def half_circle(center, options)
        case options[:side]
        when :left
          start_angle = Math::HALF_PI
          end_angle = Math::THREE_HALVES_PI
        when :right
          start_angle = Math::THREE_HALVES_PI
          end_angle = Math::HALF_PI
        end
        pie_slice(center,
          :radius => options[:radius],
          :start_angle => start_angle,
          :end_angle => end_angle,
          :stroke_both_sides => options[:stroke_both_sides])
      end

      # options must include :radius and :quadrant
      # quadrant is 1, 2, 3, or 4
      # see pie_slice for explanation of optional
      # :stroke_both_sides option
      #
      def quarter_circle(center, options)
        case options[:quadrant]
        when 1
          start_angle = 0
          end_angle = Math::HALF_PI
        when 2
          start_angle = Math::HALF_PI
          end_angle = Math::PI
        when 3
          start_angle = Math::PI
          end_angle = Math::THREE_HALVES_PI
        when 4
          start_angle = Math::THREE_HALVES_PI
          end_angle = Math::TWO_PI
        end
        pie_slice(center,
          :radius => options[:radius],
          :start_angle => start_angle,
          :end_angle => end_angle,
          :stroke_both_sides => options[:stroke_both_sides])
      end

      # options must include :radius
      #
      def centroid(center, options)
        radius = options[:radius] || 10
        pie_slice(center,
                  :radius => radius,
                  :start_angle => 0,
                  :end_angle => Math::HALF_PI,
                  :stroke_both_sides => true)
        pie_slice(center,
                  :radius => radius,
                  :start_angle => Math::PI,
                  :end_angle => Math::THREE_HALVES_PI,
                  :stroke_both_sides => true)
      end

      # options must include :radius, :start_angle, and :end_angle
      # startAngle and endAngle are in radians
      # if an optional :stroke_both_sides option is true, then both
      # sides of the slice will be included for stroking. the default is
      # to just stroke one side since this will tend to be used to build
      # up an entire circle, and if both sides were stroked, then we
      # would get double-stroked lines where two pie slices shared a
      # (not usually noticeable, but would be if transparency were used)
      #
      # 0 radians is directly right and PI/2 is straight up
      # arc will be drawn counterclockwise from startAngle to endAngle
      #
      def pie_slice(center, options)
        point = center
        point = pie_offset(center,options) if options[:offset]
        vertices = arc_vertices(point, options)
        vertices.unshift(:point => point)
        if options[:stroke_both_sides]
          closed_curve(vertices)
        else
          open_curve(vertices)
        end
      end

      # Calculate pie offset center for slice spreading
      def pie_offset(center, options)
        offset = options[:offset]
        start_angle = options[:start_angle]
        end_angle = options[:end_angle]
        start_angle = start_angle % Math::TWO_PI
        end_angle = end_angle % Math::TWO_PI
        return [center[0],center[1]] if start_angle == end_angle
        end_angle = end_angle + Math::TWO_PI if end_angle < start_angle
        mid_angle =  start_angle+(end_angle-start_angle)/2.0
        point = [center[0]+offset*Math.cos(mid_angle), center[1]+offset*Math.sin(mid_angle)]
        point
      end

      # options must include :radius, :start_angle, and :end_angle
      # startAngle and endAngle are in radians
      #
      # 0 radians is directly right and PI/2 is straight up
      # arc will be drawn counterclockwise from startAngle to endAngle
      #
      def arc_around(center, options)
        open_curve(arc_vertices(center, options))
      end

      # vertices is an array of hashes containing :vertex and optional
      # :handle1 and :handle2 elements
      def open_curve(vertices)
        return if vertices.empty?
        vertices = vertices.dup
        origin = vertices.shift
        move_to(origin[:point])
        previous_handle2 = origin[:handle2]
        vertices.each do |vertex|
          curve_to(vertex[:point],
            :bounds => [previous_handle2 || vertex[:point],
              vertex[:handle1] || vertex[:point]])
          previous_handle2 = vertex[:handle2]
        end
      end

      # vertices is an array of hashes containing :vertex and optional
      # :handle1 and :handle2 elements
      def closed_curve(vertices)
        return if vertices.empty?
        vertices = vertices.dup
        origin = vertices.shift
        move_to(origin[:point])
        previous_handle2 = origin[:handle2]
        vertices.each do |vertex|
          curve_to(vertex[:point],
            :bounds => [previous_handle2 || vertex[:point],
              vertex[:handle1] || vertex[:point]])
          previous_handle2 = vertex[:handle2]
        end
        curve_to(origin[:point],:bounds => [previous_handle2 || origin[:point],origin[:handle1] || origin[:point]])
      end

      private

      def arc_vertices(center, options)
        radius = options[:radius]
        start_angle = options[:start_angle]
        end_angle = options[:end_angle]
        return if start_angle == end_angle
        start_angle = start_angle % Math::TWO_PI
        end_angle = end_angle % Math::TWO_PI
        return circle_at(center, :radius => radius) if start_angle == end_angle

        end_angle = end_angle + Math::TWO_PI if end_angle < start_angle

        delta = end_angle - start_angle
        quadrants = (delta / Math::HALF_PI).ceil

        vertices = []
        quadrants.times do |i|
          from_angle = start_angle + Math::HALF_PI * i

          if i == quadrants - 1 then to_angle = end_angle
          else to_angle = from_angle + Math::HALF_PI
          end

          delta = to_angle - from_angle
          handle_multiplier = ::Prawn::Graphics::KAPPA * delta / Math::HALF_PI * radius

          # negate the angles so as to get the stated orientation of angles
          # start_angle = -start_angle
          # end_angle = -end_angle

          vertex = {}
          point = [Math.cos(from_angle), Math.sin(from_angle)]
          vertex[:point] = [center[0] + radius * point[0], center[1] + radius * point[1]]
          handle = point.unit_perpendicular_vector(:counter_clockwise => false)
          vertex[:handle2] = [vertex[:point][0] + handle_multiplier * handle[0],vertex[:point][1] + handle_multiplier * handle[1]]
          vertices << vertex

          vertex = {}
          point = [Math.cos(to_angle), Math.sin(to_angle)]
          vertex[:point] = [center[0] + radius * point[0],center[1] + radius * point[1]]
          handle = point.unit_perpendicular_vector(:counter_clockwise => true)
          vertex[:handle1] = [vertex[:point][0] + handle_multiplier * handle[0],vertex[:point][1] + handle_multiplier * handle[1]]
          vertices << vertex
        end
        vertices
      end
    end # Arc

  end # Shapes
end # PrawnCharts



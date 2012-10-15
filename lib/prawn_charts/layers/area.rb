
require 'prawn_charts/layers/layer'

module PrawnCharts
  module Layers

    # Area graph.
    class Area < Layer

      # Render area graph.
      def draw(pdf, coords, options={})
        # pdf.polygon wants a long string of coords.
        points_value = "0,#{height} #{stringify_coords(coords).join(' ')} #{width},#{height}"

        # Experimental, for later user.
        # This was supposed to add some fun filters, 3d effects and whatnot.
        # Neither ImageMagick nor Mozilla pdf render this well (at all).  Maybe a future thing.
        #
        # pdf.defs {
        #   pdf.filter(:id => 'MyFilter', :filterUnits => 'userSpaceOnUse', :x => 0, :y => 0, :width => 200, :height => '120') {
        #     pdf.feGaussianBlur(:in => 'SourceAlpha', :stdDeviation => 4, :result => 'blur')
        #     pdf.feOffset(:in => 'blur', :dx => 4, :dy => 4, :result => 'offsetBlur')
        #     pdf.feSpecularLighting( :in => 'blur', :surfaceScale => 5, :specularConstant => '.75',
        #                             :specularExponent => 20, 'lighting-color' => '#bbbbbb',
        #                             :result => 'specOut') {
        #       pdf.fePointLight(:x => '-5000', :y => '-10000', :z => '20000')
        #     }
        #
        #     pdf.feComposite(:in => 'specOut', :in2 => 'SourceAlpha', :operator => 'in', :result => 'specOut')
        #     pdf.feComposite(:in => 'sourceGraphic', :in2 => 'specOut', :operator => 'arithmetic',
        #                     :k1 => 0, :k2 => 1, :k3 => 1, :k4 => 0, :result => 'litPaint')
        #
        #     pdf.feMerge {
        #       pdf.feMergeNode(:in => 'offsetBlur')
        #       pdf.feMergeNode(:in => 'litPaint')
        #     }
        #   }
        # }
        pdf.g(:transform => "translate(0, -#{relative(2)})") {
          pdf.polygon(:points => points_value, :style => "fill: black; stroke: black; fill-opacity: 0.06; stroke-opacity: 0.06;")
        }

        pdf.polygon(:points => points_value, :fill => color.to_s, :stroke => color.to_s, 'style' => "opacity: #{opacity}")
      end
    end # Area

  end # Layers
end # PrawnCharts
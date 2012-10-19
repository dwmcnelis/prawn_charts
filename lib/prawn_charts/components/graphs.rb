
require 'prawn_charts/components/component'

module PrawnCharts
  module Components

    # Component for displaying Graphs layers.
    #
    # Is passed all graph layers from the Graph object.
    #
    # (This may change as the capability for Graph filtering and such fills out.)
    class Graphs < Component
      STACKED_OPACITY = 0.85;

      def draw(pdf, bounds, options={})
        pdf.stroke_color 'ff0000'
        pdf.fill_color 'ff0000'
        pdf.fill_and_stroke_centroid_mark([pdf.bounds.left+bounds[:x],pdf.bounds.bottom+bounds[:y]],:radius => 3)
        pdf.fill_and_stroke_centroid_mark([pdf.bounds.left+bounds[:x]+bounds[:width]/2.0,pdf.bounds.bottom+bounds[:y]+bounds[:height]/2.0],:radius => 3)
        pdf.text_mark ":#{id} centroid #{pdf.bounds.left+bounds[:x]+bounds[:width]/2.0},#{pdf.bounds.bottom+bounds[:y]+bounds[:height]/2.0}"
        pdf.crop_marks([pdf.bounds.left+bounds[:x],pdf.bounds.bottom+bounds[:y]+bounds[:height]],bounds[:width],bounds[:height])
        # If Graph is limited to a category, reject layers outside of it's scope.
        applicable_layers = options[:layers].reject do |l|
          if @options[:only]
            (l.options[:category].nil? && l.options[:categories].nil?) ||
              (!l.options[:category].nil? && l.options[:category] != @options[:only]) ||
              (!l.options[:categories].nil? && !l.options[:categories].include?(@options[:only]))
          else
            false
          end
        end

        applicable_layers.each_with_index do |layer, idx|
          layer_options = {}
          layer_options[:index]       = idx
          layer_options[:min_value]   = options[:min_value]
          layer_options[:max_value]   = options[:max_value]
          layer_options[:min_key]     = options[:min_key]
          layer_options[:max_key]     = options[:max_key]
          layer_options[:complexity]  = options[:complexity]
          layer_options[:size]        = [bounds[:width], bounds[:height]]
          layer_options[:color]       = layer.preferred_color || layer.color || options[:theme].next_color
          layer_options[:border]      = options[:border]
          layer_options[:outline]       = layer.preferred_outline || layer.outline || options[:theme].next_outline
          layer_options[:opacity]     = opacity_for(idx)
          layer_options[:theme]       = options[:theme]

          pdf.bounding_box([bounds[:x],bounds[:y]+bounds[:height]], :width => bounds[:width], :height => bounds[:height]) do
            layer.render(pdf, layer_options)
          end
        end
      end

      protected
      def opacity_for(idx)
        (idx == 0) ? 1.0 : (@options[:stacked_opacity] || STACKED_OPACITY)
      end

    end #Graphs

  end # Components
end # PrawnCharts


module PrawnCharts
  module Renderers

    # Provides all the base functionality needed to render a graph, but
    # does not provide a default layout.
    #
    # For a basic layout, see PrawnCharts::Renderers::Standard.
    class Renderer
      include PrawnCharts::Helpers::Canvas

      attr_accessor :pdf
      attr_accessor :options

      def initialize(options = {})
        self.components = []
        self.options = options
        define_layout
      end

      # Renders the graph and all components.
      def render(pdf,options = {})
        options[:graph_id]    ||= 'PrawnCharts_graph'
        options[:complexity]  ||= (global_complexity || :normal)

        # Allow subclasses to muck with components prior to renders.
        rendertime_renderer = self.clone
        rendertime_renderer.instance_eval { before_render if respond_to?(:before_render) }

        #svg = Builder::XmlMarkup.new(:indent => 2)
        #unless options[:no_doctype_header]
        #  svg.instruct!
        #  svg.declare! :DOCTYPE, :svg, :PUBLIC, "-//W3C//DTD SVG 1.0//EN", "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd"
        #end
        #svg.svg(:xmlns => "http://www.w3.org/2000/svg", 'xmlns:xlink' => "http://www.w3.org/1999/xlink", :width => options[:size].first, :height => options[:size].last) {
        #  svg.g(:id => options[:graph_id]) {
        rendertime_renderer.components.each do |component|
          component.render(pdf,
            bounds_for( options[:size], component.position, component.size ),
            options)
        end
        #}
        #}
        #svg.target!
      end

      def before_render
        if self.options
          set_values(self.options[:values])    if (self.options[:values] && self.options[:values] != :hide)
          hide_grid     if (self.options[:grid] == :hide)
          hide_values   if (self.options[:values] == :hide)
          hide_labels   if (self.options[:labels] == :hide)
        end
      end

      def method_missing(sym, *args)
        self.options = {} if self.options.nil?

        if args.size > 0
          self.options[sym] = args[0]
        else
          return self.options[sym]
        end
      end

      protected
      def hide_grid
        grids.each { |grid| grid.visible = false }
      end

      def set_values(val)
        values.each { |value| value.markers = val }
        grids.each { |grid| grid.markers = val }
      end

      def hide_values
        values.each { |value| value.visible = false }
      end

      def hide_labels
        labels.each { |label| label.visible = false }
      end

      private
      def global_complexity
        if Kernel.const_defined? "PrawnCharts_COMPLEXITY"
          PrawnCharts_COMPLEXITY
        else
          nil
        end
      end
    end   # Renderer

  end # Renderers
end # PrawnCharts

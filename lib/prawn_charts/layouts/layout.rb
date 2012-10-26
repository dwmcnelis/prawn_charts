
module PrawnCharts
  module Layouts

    # Provides all the base functionality needed to layout a graph, but
    # does not provide a default layout.
    #
    # For a basic layout, see PrawnCharts::Layouts::Standard.
    class Layout
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

        rendertime_renderer.components.each do |component|
          component.render(pdf,
            bounds_for( options[:size], component.position, component.size ),
            options)
        end
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
    end   # Layout

  end # Layouts
end # PrawnCharts

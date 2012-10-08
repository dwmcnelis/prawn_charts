module PrawnCharts::Components
  # Component used to limit other visual components to a certain area on the graph.
  class Viewport < Base
    include PrawnCharts::Helpers::Canvas
    
    def initialize(*args, &block)
      super(*args)
      
      self.components = []
      block.call(self.components) if block
    end

    def draw(pdf, bounds, options={})
      pdf.g(options_for) {
        self.components.each do |component|
          component.render(pdf, 
            bounds_for([bounds[:width], bounds[:height]], 
              component.position, 
              component.size), 
            options)
        end
      }
    end
    
    private
    def options_for
      options = {}
      %w(skewX skewY).each do |option|
        if @options[option.to_sym]
          options[:transform] ||= ''
          options[:transform] = options[:transform] + "#{option.to_s}(#{@options[option.to_sym]})"
        end
      end
      options
    end
  end
end
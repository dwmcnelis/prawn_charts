
require 'prawn_charts/layouts/layout'

module PrawnCharts
  module Layouts

    # An Empty graph isn't completely empty, it adds a background component
    # to itself before handing other all other layout responsibilities to it's
    # subclasses or caller.
    class Empty < Layout

      # Returns a layout with just a background.
      #
      # If a block is provided, the components array is passed to
      # the block, allowing callers to add components during initialize.
      def define_layout
        self.components << PrawnCharts::Components::Background.new(:background, :position => [0,0], :size =>[100, 100])

        yield(self.components) if block_given?
      end
    end # Empty

  end # Layouts
end # PrawnCharts

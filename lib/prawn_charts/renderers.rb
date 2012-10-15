
require 'prawn_charts/renderers/renderer'
require 'prawn_charts/renderers/axis_legend'
require 'prawn_charts/renderers/basic'
require 'prawn_charts/renderers/cubed'
require 'prawn_charts/renderers/cubed3d'
require 'prawn_charts/renderers/default'
require 'prawn_charts/renderers/empty'
require 'prawn_charts/renderers/pie'
require 'prawn_charts/renderers/reversed'
require 'prawn_charts/renderers/spark_line'
require 'prawn_charts/renderers/split'

# Renderers piece the entire graph together from a collection
# of components.  Creating new renderers allows you to create
# entirely new layouts for your graphs.
#
# PrawnCharts::Renderers::Renderer contains the basic functionality needed
# by a layout.  The easiest way to create a new layout is by sub-classing
# Renderer.
module PrawnCharts
  module Renderers
  end # Renderers
end # PrawnCharts

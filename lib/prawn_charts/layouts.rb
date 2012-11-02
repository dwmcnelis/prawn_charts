
require 'prawn_charts/layouts/layout'
require 'prawn_charts/layouts/axis_legend'
require 'prawn_charts/layouts/basic'
require 'prawn_charts/layouts/bar'
require 'prawn_charts/layouts/cubed'
require 'prawn_charts/layouts/cubed3d'
require 'prawn_charts/layouts/default'
require 'prawn_charts/layouts/empty'
require 'prawn_charts/layouts/legend'
require 'prawn_charts/layouts/pie'
require 'prawn_charts/layouts/reversed'
require 'prawn_charts/layouts/spark_line'
require 'prawn_charts/layouts/split'
require 'prawn_charts/layouts/test'

# Layouts piece the entire graph together from a collection
# of components.  Creating new layouts allows you to create
# entirely new layouts for your graphs.
#
# PrawnCharts::Layouts::Layout contains the basic functionality needed
# by a layout.  The easiest way to create a new layout is by sub-classing
# Layout.
module PrawnCharts
  module Layouts
  end # Layouts
end # PrawnCharts


require 'prawn_charts/layers/base'
require 'prawn_charts/layers/area'
require 'prawn_charts/layers/multi_area'
require 'prawn_charts/layers/all_smiles'
require 'prawn_charts/layers/bar'
require 'prawn_charts/layers/box'
require 'prawn_charts/layers/line'
require 'prawn_charts/layers/average'
require 'prawn_charts/layers/stacked'
require 'prawn_charts/layers/multi'
require 'prawn_charts/layers/multi_bar'
require 'prawn_charts/layers/pie'
require 'prawn_charts/layers/pie_slice'
require 'prawn_charts/layers/scatter'

module PrawnCharts::Layers

  # Should be raised whenever a predictable error during rendering occurs,
  # particularly if you do not want to terminate the graph rendering process.
  class RenderError < StandardError; end
  
end


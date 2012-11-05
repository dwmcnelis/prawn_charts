
require 'forwardable'
  
module PrawnCharts

  # PrawnCharts::Graph is the primary class you will use to generate your graphs.  A Graph does not
  # define a graph type nor does it directly hold any data.  Instead, a Graph object can be thought
  # of as a canvas on which other graphs are draw.  (The actual graphs themselves are subclasses of PrawnCharts::Layers::Base)
  # Despite the technical distinction, we will refer to PrawnCharts::Graph objects as 'graphs' and PrawnCharts::Layers as
  # 'layers' or 'graph types.'
  #
  #
  # ==== Creating a Graph
  #
  # You can begin building a graph by instantiating a Graph object and optionally passing a hash
  # of properties.
  #
  #   graph = PrawnCharts::Graph.new
  #
  #   OR
  #
  #   graph = PrawnCharts::Graph.new(:title => "Monthly Profits", :theme => PrawnCharts::Themes::RubyBlog.new)
  #
  # Once you have a Graph object, you can set any Graph-level properties (title, theme, etc), or begin adding
  # graph layers.  You can add a graph layer to a graph by using the Graph#add or Graph#<< methods.  The two
  # methods are identical and used to accommodate syntax preferences.
  #
  #   graph.add(:line, 'John', [100, -20, 30, 60])
  #   graph.add(:line, 'Sara', [120, 50, -80, 20])
  #
  #   OR
  #
  #   graph << PrawnCharts::Layers::Line.new(:title => 'John', :points => [100, -20, 30, 60])
  #   graph << PrawnCharts::Layers::Line.new(:title => 'Sara', :points => [120, 50, -80, 20])
  #
  # Now that we've created our graph and added a layer to it, we're ready to render!
  #
  #   graph.render    # Renders a 600x400 PDF graph
  #
  #   OR
  #
  #   graph.render(:width => 1200)
  #
  # And that's your basic PrawnCharts graph!  Please check the documentation for the various methods and
  # classes you'll be using, as there are a bunch of options not demonstrated here.
  #
  # A couple final things worth noting:
  # * You can call Graph#render as often as you wish with different rendering options.  In
  #   fact, you can modify the graph any way you wish between renders.
  #
  #
  # * There are no restrictions to the combination of graph layers you can add.  It is perfectly
  #   valid to do something like:
  #     graph.add(:line, [100, 200, 300])
  #     graph.add(:bar, [200, 150, 150])
  #
  #   Of course, while you may be able to combine some things such as pie charts and line graphs, that
  #   doesn't necessarily mean they will make any logical sense together.  We leave those decisions up to you. :)

  class Graph
    extend Forwardable

    include PrawnCharts::Helpers::LayerContainer

    # Delegating these getters to the internal state object.
    def_delegators  :internal_state, :title,:x_legend,:y_legend, :theme, :default_type,
      :point_markers,:point_markers_rotation,:point_markers_ticks, :value_formatter,
      :key_formatter

    def_delegators  :internal_state, :title=, :theme=,:x_legend=,:y_legend=, :default_type=,
      :point_markers=,:point_markers_rotation=,:point_markers_ticks=, :value_formatter=,
      :key_formatter=

    attr_reader :layout     # Writer defined below

    # Returns a new Graph.  You can optionally pass in a default graph type and an options hash.
    #
    #   Graph.new           # New graph
    #   Graph.new(:line)    # New graph with default graph type of Line
    #   Graph.new({...})    # New graph with options.
    #
    # Options:
    #
    # title::  Graph's title
    # x_legend :: Title for X Axis
    # y_legend :: Title for Y Axis
    # theme::  A theme object to use when rendering graph
    # layers::  An array of Layers for this graph to use
    # default_type::  A symbol indicating the default type of Layer for this graph
    # value_formatter::   Sets a formatter used to modify marker values prior to rendering
    # point_markers::  Sets the x-axis marker values
    # point_markers_rotation::  Sets the angle of rotation for x-axis marker values
    # point_markers_ticks::  Sets a small tick mark above each marker value.  Helpful when used with rotation.
    def initialize(*args)
      self.default_type   = args.shift if args.first.is_a?(Symbol)
      options             = args.shift.dup if args.first.is_a?(Hash)
      raise ArgumentError, "The arguments provided are not supported." if args.size > 0

      options ||= {}

      self.theme = PrawnCharts::Themes::Default.new
      self.layout = PrawnCharts::Layouts::Default.new
      self.value_formatter = PrawnCharts::Formatters::Number.new
      self.key_formatter = PrawnCharts::Formatters::Number.new

      %w(title x_legend y_legend theme layers default_type value_formatter point_markers point_markers_rotation point_markers_ticks layout key_formatter marks).each do |arg|
        self.send("#{arg}=".to_sym, options.delete(arg.to_sym)) unless options[arg.to_sym].nil?
      end

      raise ArgumentError, "Some options provided are not supported: #{options.keys.join(' ')}." if options.size > 0
    end

    # Renders the graph in it's current state into a PDF object.
    #
    # Options:
    # size:: An array indicating the size you wish to render the graph.  ( [x, y] )
    # width:: The width of the rendered graph.  A height is calculated at 3/4th of the width.
    # theme:: Theme used to render graph for this render only.
    # min_value:: Overrides the calculated minimum value used for the graph.
    # max_value:: Overrides the calculated maximum value used for the graph.
    # layout:: Provide a Layout object to use instead of the default.
    def render(pdf,options = {})
      options[:theme]               ||= theme
      options[:value_formatter]     ||= value_formatter
      options[:key_formatter]       ||= key_formatter
      options[:point_markers]       ||= point_markers
      options[:point_markers_rotation]       ||= point_markers_rotation
      options[:point_markers_ticks]       ||= point_markers_ticks
      options[:size]                ||= (options[:width] ? [options[:width], (options.delete(:width) * 0.6).to_i] : [600, 360])
      options[:title]               ||= title
      options[:x_legend]               ||= x_legend
      options[:y_legend]               ||= y_legend
      options[:layers]              ||= layers
      options[:min_value]           ||= bottom_value(options[:padding] ? options[:padding] : nil)
      options[:max_value]           ||= top_value(options[:padding] ? options[:padding] : nil)
      options[:min_key]             ||= bottom_key
      options[:max_key]             ||= top_key
      options[:graph]               ||= self

      @at = options[:at] || [0,0]
      @width = (options[:size] ? options[:size][0] : 600)
      @height = (options[:size] ? options[:size][1] : 360)
      pdf.bounding_box([@at[0],@at[1]], :width => @width, :height => @height) do
        pdf.reset_text_marks
        #pdf.text_mark ":#{id} centroid #{pdf.bounds.left+bounds[:x]+bounds[:width]/2.0,},#{pdf.bounds.bottom+bounds[:y]+bounds[:height]/2.0], :radius => 3}"
        pdf.centroid_mark([pdf.bounds.left+pdf.bounds.width/2.0,pdf.bounds.bottom+pdf.bounds.height/2.0+pdf.bounds.height],:radius => 3)
        pdf.crop_marks([pdf.bounds.left,pdf.bounds.bottom+pdf.bounds.height],pdf.bounds.width,pdf.bounds.height)
        if !options[:layout].nil?
          options[:layout].render(pdf,options)
        else
          self.layout.render(pdf,options)
        end
      end
    end

    def layout=(options)
      raise ArgumentError, "Layout must include a #render(options) method." unless (options.respond_to?(:render) && options.method(:render).arity.abs > 0)
      @layout = options
    end

    def component(id)
      layout.component(id)
    end

    def remove(id)
      layout.remove(id)
    end

    private
    def internal_state
      @internal_state ||= GraphState.new
    end
  end # Graph

end # PrawnChars
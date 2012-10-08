module PrawnCharts
  module Components
    # Component used for adding CSS styling to pdf graphs.
    #
    # In hindsight, ImageMagick and Mozilla pdf's handling of CSS styling is
    # extremely inconsistant, so use this at your own risk.
    class StyleInfo < Base
      def initialize(*args)
        super
        
        @visible = false
      end
      def process(pdf, options={})
        pdf.defs {
          pdf.style(:type => "text/css") {
            pdf.cdata!("\n#{options[:selector]} {\n    #{options[:style]}\n}\n")
          }
        }
      end
    end
  end
end
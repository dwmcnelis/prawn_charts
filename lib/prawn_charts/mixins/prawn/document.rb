
require 'prawn_charts/shapes'

module Prawn
  class Document
    include PrawnCharts::Shapes

    def log_reset
      $LOG_Y = bounds.top
    end

    def log_text(text,level=:debug,options={})
      $LOG_Y = $LOG_Y || bounds.top
      fill_color (level == :fatal ? 'ff0000' : (level == :error ? '990033' : (level == :warn ? 'ffff00' : (level == :debug ? 'cc0066' : '6699cc'))))
      prefix = (level == :fatal ? 'FATAL' : (level == :error ? 'ERROR' : (level == :warn ? 'WARN' : (level == :debug ? 'DEBUG' : 'INFO'))))
      font_family = "Helvetica"
      font_size = 8
      font(font_family) do
        text_box "#{prefix}: #{text}", :at => [0,$LOG_Y], :size => font_size
      end
      fill_color '000000'
      $LOG_Y = $LOG_Y - font_size
    end
  end
end
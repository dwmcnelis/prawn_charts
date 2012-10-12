
require 'prawn_charts/shapes'

module Prawn
  class Document
    include PrawnCharts::Shapes

    def log_reset(y=752)
      $LOG_Y = y
    end

    def log_text(text,level=:debug,options={})
      $LOG_Y = $LOG_Y || 700
      $LOG_Y = $LOG_Y - 12
      fill_color (level == :fatal ? 'ff0000' : (level == :error ? '990033' : (level == :warn ? 'ffff00' : (level == :debug ? 'cc0066' : '6699cc'))))
      prefix = (level == :fatal ? 'FATAL' : (level == :error ? 'ERROR' : (level == :warn ? 'WARN' : (level == :debug ? 'DEBUG' : 'INFO'))))
      text_box "#{prefix}: #{text}", :at => [0,$LOG_Y]
      fill_color '000000'
    end
  end
end
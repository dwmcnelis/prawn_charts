# -*- encoding: utf-8 -*-
require File.expand_path('../lib/prawn_charts/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Dave McNelis"]
  gem.email         = ["davemcnelis@market76.com"]
  gem.description   = %q{PrawnCharts Graphing Library for Prawn
(adapted from Scruffy by Brasten Sager)}
  gem.summary       = %q{PrawnCharts Graphing Library for Prawn
(adapted from Scruffy by Brasten Sager)}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "prawn_charts"
  gem.require_paths = ["lib"]
  gem.version       = PrawnCharts::VERSION
end

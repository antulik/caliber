
# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'caliber/version'

Gem::Specification.new do |gem|
  gem.name          = "caliber"
  gem.version       = Caliber::VERSION
  gem.authors       = ["Anton Katunin"]
  gem.email         = ["katunin.anton+rubygems@gmail.com"]
  gem.description   = %q{Caliber is a Rails engine that shows css classes}
  gem.summary       = %q{Caliber is a Rails engine that shows css classes}
  gem.homepage      = "https://github.com/antulik/caliber"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "rails", ">= 3.2"

  gem.add_development_dependency "capybara", ">= 0.4.0"
  gem.add_development_dependency "launchy", "~> 2.1.0"
  gem.add_development_dependency "poltergeist"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "sqlite3"
end
# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chain/version'

Gem::Specification.new do |gem|
  gem.name          = "chain"
  gem.version       = Chain::VERSION
  gem.authors       = ["Thiago Dantas"]
  gem.email         = ["thiago.teixeira.dantas@gmail.com"]
  gem.description   = %q{Chain Chain Chain everything}
  gem.summary       = %q{Chain your code}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec', '~> 2.14.1'
  gem.add_development_dependency 'rake', '~> 10.2.1'
  gem.add_development_dependency 'coveralls', '~> 0.7'

end

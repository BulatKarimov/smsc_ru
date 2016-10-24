lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smsc/version'

Gem::Specification.new do |spec|
  spec.name          = 'smsc_ru'
  spec.version       = Smsc::VERSION
  spec.authors       = ['Kirill Sapozhnikov']
  spec.email         = ['ksapozhnikov@spbtv.com']

  spec.summary       = 'Api client for smsc.ru'
  spec.description   = 'Api client for smsc.ru'
  spec.homepage      = 'https://github.com/SPBTV/smsc_ru.git'
  spec.license       = 'Apache 2.0'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.bindir        = 'exe'
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '~> 0.9'
  spec.add_dependency 'addressable', '~> 2.3'
  spec.add_dependency 'virtus', '~> 1.0'

  spec.add_development_dependency 'bundler', '>= 1.9'
  spec.add_development_dependency 'rake', '~> 11.3'
  spec.add_development_dependency 'rspec', '~> 3.3'
  spec.add_development_dependency 'vcr', '~> 3.0'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'webmock', '~> 2.1'
  spec.add_development_dependency 'rubocop', '~> 0.44'
  spec.add_development_dependency 'yard', '~> 0.9'
end


lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/namecheap/version'

Gem::Specification.new do |spec|
  spec.name          = 'omniauth-namecheap'
  spec.version       = Omniauth::Namecheap::VERSION
  spec.authors       = ['Rachel Carvalho']
  spec.email         = ['rachel.carvalho@gmail.com']

  spec.summary       = 'Omniauth strategy for Namecheap'
  spec.homepage      = 'https://github.com/rachel-carvalho/omniauth-namecheap'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'omniauth-oauth2', '~> 1.4'
  spec.add_runtime_dependency 'oauth2', '~> 1.3'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.2'
  spec.add_development_dependency 'pry-byebug', '~> 3.6'
end

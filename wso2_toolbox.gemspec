
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wso2_toolbox/version'

Gem::Specification.new do |spec|
  spec.name          = 'wso2_toolbox'
  spec.version       = Wso2Toolbox::VERSION
  spec.authors       = ['Abner Carleto']
  spec.email         = ['abner.carleto@cedrotech.com']

  spec.summary       = 'WSO2 useful tools'
  spec.homepage      = 'https://bitbucket.org/guideinvestimentos/wso2_toolbox'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'actionpack', '>= 5.0'
  spec.add_dependency 'activesupport', '>= 5.0'
  spec.add_dependency 'request_store', '~> 1.3.2'
  spec.add_dependency 'rest-client', '>= 2.0.2'

  spec.add_development_dependency 'bundler', '~> 1.15.4'
  spec.add_development_dependency 'dotenv'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rails-controller-testing', '~> 1.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'shoulda-matchers', '~> 3.1'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end

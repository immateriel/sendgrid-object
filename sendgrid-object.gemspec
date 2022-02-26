lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sendgrid/version'

Gem::Specification.new do |spec|
  spec.name          = "sendgrid-object"
  spec.version       = Sendgrid::VERSION
  spec.authors       = ["Elodie Ailleaume"]
  spec.email         = ["elodie@immateriel.fr"]

  spec.summary       = %q{OOP use of the sendgrid API}
  spec.description   = %q{OOP use of the sendgrid API}
  spec.homepage      = "http://www.immateriel.fr"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(/^(test|spec|features)/)
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage

  spec.require_paths = ["lib"]

  spec.add_dependency 'sendgrid-ruby', "~> 6.6.1"

  spec.add_development_dependency 'rspec', "~> 3.11"
  spec.add_development_dependency 'webmock', "~> 3.14.0"
end

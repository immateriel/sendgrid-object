Gem::Specification.new do |spec|
  spec.name          = "sendgrid-object"
  spec.version       = Sendgrid::VERSION
  spec.authors       = ["Elodie Ailleaume"]
  spec.email         = ["elodie@immateriel.fr"]

  spec.summary       = %q{OOP use of the sendgrid API}
  spec.description   = %q{OOP use of the sendgrid API}
  spec.homepage      = "http://www.immateriel.fr"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.require_paths = ["lib"]

  spec.add_dependency 'sendgrid-ruby', "~> 6.6.1"
end

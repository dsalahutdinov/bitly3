
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bitly3/version"

Gem::Specification.new do |spec|
  spec.name          = "bitly3"
  spec.version       = Bitly3::VERSION
  spec.authors       = ["Salahutdinov Dmitry"]
  spec.email         = ["dsalahutdinov@gmail.com"]

  spec.summary       = %q{Wrapper for Bitly API v3}
  spec.description   = %q{A Ruby interface to the Bitly API v3.}
  spec.homepage      = "https://github.com/dsalahutdinov/bitly3"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 0.54"
  spec.add_development_dependency "dotenv"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "byebug"

  spec.add_runtime_dependency "oauth2"
  spec.add_runtime_dependency "oj"
  spec.add_runtime_dependency "httparty"
end

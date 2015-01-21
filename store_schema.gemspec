lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "store_schema/version"

Gem::Specification.new do |spec|
  spec.name = "store_schema"
  spec.version = StoreSchema::VERSION
  spec.authors = ["Michael van Rooijen"]
  spec.email = ["michael@vanrooijen.io"]
  spec.summary = %q{Enhances ActiveRecord::Base.store_accessor with data conversion capabilities.}
  spec.homepage = "http://meskyanichi.github.io/store_schema/"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 4.0.0"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.4.2"
  spec.add_development_dependency "rspec", "~> 3.1.0"
  spec.add_development_dependency "sqlite3", "~> 1.3.10"
  spec.add_development_dependency "database_cleaner", "~> 1.4.0"
  spec.add_development_dependency "pry", "~> 0.10.1"
  spec.add_development_dependency "simplecov", "~> 0.9.1"
  spec.add_development_dependency "yard", "~> 0.8.7.6"
end

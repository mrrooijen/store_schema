lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "store_schema/version"

Gem::Specification.new do |s|
  s.name     = "store_schema"
  s.version  = StoreSchema::VERSION
  s.license  = "MIT"
  s.summary  = %q{Enhances `ActiveRecord::Base.store_accessor` with data type conversion capabilities.}
  s.authors  = ["Michael van Rooijen"]
  s.email    = ["michael@vanrooijen.io"]
  s.homepage = "https://github.com/mrrooijen/store_schema"
  s.files    = `git ls-files -- lib README.md CHANGELOG.md LICENSE`.split("\n")
  s.add_dependency "activerecord", ">= 5.1.0"
  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"
  s.add_development_dependency "minitest"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "yard"
  s.required_ruby_version = ">= 2.5.0"
end

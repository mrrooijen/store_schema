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
  s.add_dependency "activerecord", ">= 6.0.0"
  s.add_development_dependency "bundler"
  s.add_development_dependency "rake", "~> 13.0.3"
  s.add_development_dependency "minitest", "~> 5.14.4"
  s.add_development_dependency "pg", "~> 1.2.3"
  s.add_development_dependency "mysql2", "~> 0.5.3"
  s.add_development_dependency "sqlite3", "~> 1.4.2"
  s.add_development_dependency "simplecov", "~> 0.21.2"
  s.add_development_dependency "yard", "~> 0.9.26"
  s.required_ruby_version = ">= 2.5.0"
end

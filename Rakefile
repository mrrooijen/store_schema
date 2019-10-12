require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

desc "Runs the doc server (yard)"
task :doc do |t, args|
  require "yard"
  YARD::CLI::CommandParser.run("server", "--reload")
end

desc "Run tests"
task :default => :test

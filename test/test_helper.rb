require "simplecov"
SimpleCov.start
require "sqlite3"
require "active_record"
require_relative "../lib/store_schema"
require_relative "support/db"
require_relative "support/models"
require "minitest/autorun"
require "minitest/spec"

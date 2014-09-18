module StoreSchema::Module

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    # @example
    #
    #   # Gemfile
    #   gem "store_schema"
    #
    #   # app/models/project.rb
    #   class Website < ActiveRecord::Base
    #
    #     store_schema :config do |s|
    #       s.string :name
    #       s.integer :visitors
    #       s.float :apdex
    #       s.boolean :ssl
    #       s.datetime :published_at
    #     end
    #   end
    #
    # @param column [Symbol] name of the table column
    # @param block [Proc] the configuration block
    #
    def store_schema(column, &block)
      StoreSchema::Configuration.new(column).tap do |config|
        yield(config)
        config.send(:configure, self)
      end
    end
  end
end

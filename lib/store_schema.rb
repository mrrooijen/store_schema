module StoreSchema
  require_relative "store_schema/accessor_definer"
  require_relative "store_schema/configuration"
  require_relative "store_schema/converter"
  require_relative "store_schema/module"
  require_relative "store_schema/version"
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.send(:include, StoreSchema::Module)
end

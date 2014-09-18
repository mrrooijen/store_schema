module StoreSchema
  require "store_schema/accessor_definer"
  require "store_schema/configuration"
  require "store_schema/converter"
  require "store_schema/module"
  require "store_schema/version"
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.send(:include, StoreSchema::Module)
end

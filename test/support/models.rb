class CommonModel < ActiveRecord::Base
  self.abstract_class = true
  store_schema :config do |s|
    s.string   :name
    s.integer  :visitors
    s.float    :apdex
    s.boolean  :ssl
    s.datetime :published_at
  end
end

class PostgreSQLModel < CommonModel
  self.abstract_class = true
  establish_connection(CONNECTIONS[:postgresql])
end

class PostgreSQLJSONWebsite < PostgreSQLModel
  store :config, coder: JSON
end

class PostgreSQLYAMLWebsite < PostgreSQLModel
  store :config, coder: YAML
end

class PostgreSQLHStoreWebsite < PostgreSQLModel
end

class MySQLModel < CommonModel
  self.abstract_class = true
  establish_connection(CONNECTIONS[:mysql])
end

class MySQLJSONWebsite < MySQLModel
  store :config, coder: JSON
end

class MySQLYAMLWebsite < MySQLModel
  store :config, coder: YAML
end

class SQLiteModel < CommonModel
  self.abstract_class = true
  establish_connection(CONNECTIONS[:sqlite])
end

class SQLiteJSONWebsite < SQLiteModel
  store :config, coder: JSON
end

class SQLiteYAMLWebsite < SQLiteModel
  store :config, coder: YAML
end

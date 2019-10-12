class WebsiteJSON < ActiveRecord::Base
  self.table_name = "websites_json"

  store :config, coder: JSON

  store_schema :config do |s|
    s.string   :name
    s.integer  :visitors
    s.float    :apdex
    s.boolean  :ssl
    s.datetime :published_at
  end
end

class WebsiteYAML < ActiveRecord::Base
  self.table_name = "websites_yaml"

  store :config, coder: YAML

  store_schema :config do |s|
    s.string   :name
    s.integer  :visitors
    s.float    :apdex
    s.boolean  :ssl
    s.datetime :published_at
  end
end

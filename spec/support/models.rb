class Website < ActiveRecord::Base

  store :config, coder: JSON

  store_schema :config do |s|
    s.string :name
    s.integer :visitors
    s.float :apdex
    s.boolean :ssl
    s.datetime :published_at
  end
end

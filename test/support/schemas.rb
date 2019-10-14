# PostgreSQL
ActiveRecord::Base.establish_connection(CONNECTIONS[:prepare][:postgresql])
ActiveRecord::Base.connection.recreate_database(CONNECTIONS[:postgresql][:database])
ActiveRecord::Base.establish_connection(CONNECTIONS[:postgresql])
Class.new(ActiveRecord::Migration[5.1]) do
  def change
    enable_extension "hstore"

    create_table :postgre_sqlyaml_websites do |t|
      t.text :config
    end

    create_table :postgre_sqljson_websites do |t|
      t.text :config
    end

    create_table :postgre_sqlh_store_websites do |t|
      t.hstore :config
    end
  end
end.new.change

# MySQL
ActiveRecord::Base.establish_connection(CONNECTIONS[:prepare][:mysql])
ActiveRecord::Base.connection.recreate_database(CONNECTIONS[:mysql][:database])
ActiveRecord::Base.establish_connection(CONNECTIONS[:mysql])
Class.new(ActiveRecord::Migration[5.1]) do
  def change
    create_table :my_sqlyaml_websites do |t|
      t.text :config
    end

    create_table :my_sqljson_websites do |t|
      t.text :config
    end
  end
end.new.change

# SQLite
File.delete(CONNECTIONS[:sqlite][:database]) if File.exist?(CONNECTIONS[:sqlite][:database])
ActiveRecord::Base.establish_connection(CONNECTIONS[:sqlite])
Class.new(ActiveRecord::Migration[5.1]) do
  def change
    create_table :sq_lite_yaml_websites do |t|
      t.text :config
    end

    create_table :sq_lite_json_websites do |t|
      t.text :config
    end
  end
end.new.change

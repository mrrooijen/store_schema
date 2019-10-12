ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

class Schema < ActiveRecord::Migration[5.1]

  def change
    create_table :websites_json do |t|
      t.text :config
    end

    create_table :websites_yaml do |t|
      t.text :config
    end
  end
end

Schema.new.change

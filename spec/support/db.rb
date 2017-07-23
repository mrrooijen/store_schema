ActiveRecord::Base.establish_connection(
  adapter: "sqlite3", database: ":memory:"
)

class Schema < ActiveRecord::Migration[4.2]

  def change
    create_table :websites do |t|
      t.text :config
    end
  end
end

Schema.new.change

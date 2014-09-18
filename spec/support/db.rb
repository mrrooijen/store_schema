ActiveRecord::Base.logger = Logger.new(LOG_PATH)
ActiveRecord::Base.establish_connection(
  adapter: "sqlite3", database: ":memory:"
)

class Schema < ActiveRecord::Migration

  def change
    create_table :websites do |t|
      t.text :config
    end
  end
end

silence_stream(STDOUT) do
  Schema.new.change
end

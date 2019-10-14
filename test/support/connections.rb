sqlite3_db = File.expand_path("../../../tmp/db.sqlite3" ,__FILE__)

CONNECTIONS = {
  :prepare => {
    :postgresql => {
      :adapter  => "postgresql",
      :database => "postgres",
    },
    :mysql => {
      :adapter  => "mysql2",
      :username => "root",
    },
    :sqlite3 => {
      :database => sqlite3_db,
    }
  },
  :postgresql => {
    :adapter  => "postgresql",
    :database => "store_schema",
  },
  :mysql => {
    :adapter  => "mysql2",
    :database => "store_schema",
    :username => "root",
  },
  :sqlite     => {
    :adapter  => "sqlite3",
    :database => sqlite3_db
  }
}

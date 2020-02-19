CONNECTIONS = {
  :prepare => {
    :postgresql => "postgres://#{`whoami`.strip}:postgres@127.0.0.1:5432/postgres",
    :mysql      => "mysql2://root:root@127.0.0.1:3306/store_schema",
  },
  :postgresql => "postgres://#{`whoami`.strip}:postgres@127.0.0.1:5432/store_schema",
  :mysql      => "mysql2://root:root@127.0.0.1:3306/store_schema",
  :sqlite3    => "sqlite3:tmp/store_schema.sqlite3",
}

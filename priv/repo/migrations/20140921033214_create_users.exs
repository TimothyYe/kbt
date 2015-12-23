defmodule Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def up do
    execute "CREATE TABLE IF NOT EXISTS users(id serial primary key, name varchar(20) unique, email varchar(20) unique, admin boolean DEFAULT FALSE, password varchar(255))"
  end

  def down do
    execute "DROP TABLE users"
  end
end

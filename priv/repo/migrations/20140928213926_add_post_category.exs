defmodule Repo.Migrations.CreatePostCategory do
  use Ecto.Migration

  def up do
    execute "CREATE TABLE categories(id serial primary key, name varchar(255) unique)"
    execute "INSERT INTO categories VALUES (1, '键盘交流')"
    execute "INSERT INTO categories VALUES (2, '二手交易')"
    execute "INSERT INTO categories VALUES (3, '代购专区')"
    execute "ALTER TABLE posts ADD category_id integer REFERENCES categories(id)"
  end

  def down do
    execute "ALTER TABLE posts DROP category_id"
    execute "DROP TABLE categories"
  end
end

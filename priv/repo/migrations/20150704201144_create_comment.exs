defmodule NeepBlogBackend.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :text

      timestamps
    end

  end
end

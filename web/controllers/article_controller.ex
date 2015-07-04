defmodule NeepBlogBackend.ArticleController do
  use NeepBlogBackend.Web, :controller

  alias NeepBlogBackend.Article

  plug :scrub_params, "article" when action in [:create, :update]

  def index(conn, _params) do
    # articles = Repo.all(Article)
    articles = Neo4jConnector.all!(%Article{})
    # render(conn, "index.html", articles: articles)
    render(conn, :index, articles: articles)
  end

  def new(conn, _params) do
    changeset = Article.changeset(%Article{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"article" => article_params}) do
    changeset = Article.changeset(%Article{}, article_params)

    if changeset.valid? do
      # Repo.insert!(changeset)
      Neo4jConnector.insert!(changeset)

      conn
      |> put_flash(:info, "Article created successfully.")
      |> redirect(to: article_path(conn, :index))
    else
      render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    # article = Repo.get!(Article, id)
    article = Neo4jConnector.get!(%Article{}, id)
    IO.inspect article
    render(conn, :show, article: article)
  end

  def edit(conn, %{"id" => id}) do
    # article = Repo.get!(Article, id)
    article = Neo4jConnector.get!(%Article{}, id)
    changeset = Article.changeset(article)
    IO.inspect changeset
    render(conn, :edit, article: article, changeset: changeset)
  end

  def update(conn, %{"id" => id, "article" => article_params}) do
    # article = Repo.get!(Article, id)
    article = Neo4jConnector.get!(%Article{}, id)
    changeset = Article.changeset(article, article_params)

    if changeset.valid? do
      # Repo.update!(changeset)
      Neo4jConnector.update!(changeset)

      conn
      |> put_flash(:info, "Article updated successfully.")
      |> redirect(to: article_path(conn, :index))
    else
      render(conn, :edit, article: article, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    # article = Repo.get!(Article, id)
    # Repo.delete!(article)
    article = Neo4jConnector.get!(%Article{}, id)
    Neo4jConnector.delete!(article)

    conn
    |> put_flash(:info, "Article deleted successfully.")
    |> redirect(to: article_path(conn, :index))
  end
end

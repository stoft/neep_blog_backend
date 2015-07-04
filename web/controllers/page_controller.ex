defmodule NeepBlogBackend.PageController do
  use NeepBlogBackend.Web, :controller

  alias NeepBlogBackend.Article

  def index(conn, _params) do
    articles = Neo4jConnector.all!(%Article{})
    render conn, "index.html", articles: articles
  end
end

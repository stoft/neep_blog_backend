defmodule NeepBlogBackend.PageController do
  use NeepBlogBackend.Web, :controller

  alias NeepBlogBackend.Article

  def index(conn, _params) do
    articles = Neo4jConnector.all!(%Article{})
    render conn, :index, articles: articles
  end

  def api(conn, _params) do
    render conn, :index, []
  end
  
end

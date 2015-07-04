defmodule NeepBlogBackend.ArticleView do
  use NeepBlogBackend.Web, :view

  alias NeepBlogBackend.Endpoint

  def render("index.json", %{articles: articles}) do
    render_many(articles, "article.json")
  end

  def render("show.json", %{article: article}) do
    render_one(article, "article.json")
  end

  def render("article.json", %{article: article}) do
    %{data: %{id: article.id,
      title: article.title,
      body: article.body,
      inserted_at: article.inserted_at,
      updated_at: article.updated_at},
      self: article_url(Endpoint, :show, article.id)}
  end
end

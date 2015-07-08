defmodule NeepBlogBackend.PageView do
  use NeepBlogBackend.Web, :view

  alias NeepBlogBackend.Endpoint

  # def render("index.json", params) do
  #   IO.inspect params
  #   render_one(nil, "api.json")
  # end

  def render("index.json", _params) do
    %{articles: article_url(Endpoint, :index)}
  end
  
end

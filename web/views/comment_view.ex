defmodule NeepBlogBackend.CommentView do
  use NeepBlogBackend.Web, :view

  def render("index.json", %{comments: comments}) do
    %{data: render_many(comments, "comment.json")}
  end

  def render("show.json", %{comment: comment}) do
    %{data: render_one(comment, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    %{id: comment.id}
  end
end

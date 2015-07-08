defmodule NeepBlogBackend.CommentController do
  use NeepBlogBackend.Web, :controller

  alias NeepBlogBackend.Comment

  plug :scrub_params, "comment" when action in [:create, :update]

  def index(conn, %{"article_id" => article_id}) do
    # comments = Repo.all(Comment)
    # render(conn, :index, comments: comments)
    conn
    |> put_status(:not_found)
    |> render(HelloPhoenix.ErrorView, "404.html")
  end

  def create(conn, %{"comment" => comment_params}) do
    conn
    |> put_status(:not_found)
    |> render(HelloPhoenix.ErrorView, "404.html")

  #   changeset = Comment.changeset(%Comment{}, comment_params)
  #
  #   if changeset.valid? do
  #     comment = Repo.insert!(changeset)
  #     render(conn, :show, comment: comment)
  #   else
  #     conn
  #     |> put_status(:unprocessable_entity)
  #     |> render(NeepBlogBackend.ChangesetView, :error, changeset: changeset)
  #   end
  end

  def show(conn, %{"id" => id}) do
    conn
    |> put_status(:not_found)
    |> render(HelloPhoenix.ErrorView, "404.html")
    # comment = Repo.get!(Comment, id)
    # render conn, :show, comment: comment
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    conn
  |> put_status(:not_found)
  |> render(HelloPhoenix.ErrorView, "404.html")
    # comment = Repo.get!(Comment, id)
    # changeset = Comment.changeset(comment, comment_params)
    #
    # if changeset.valid? do
    #   comment = Repo.update!(changeset)
    #   render(conn, :show, comment: comment)
    # else
    #   conn
    #   |> put_status(:unprocessable_entity)
    #   |> render(NeepBlogBackend.ChangesetView, :error, changeset: changeset)
    # end
  end

  def delete(conn, %{"id" => id}) do
    conn
    |> put_status(:not_found)
    |> render(HelloPhoenix.ErrorView, "404.html")
  # comment = Repo.get!(Comment, id)
  #
  # comment = Repo.delete!(comment)
  # render(conn, :show, comment: comment)
  end
end

defmodule Neo4jConnector do
  use Timex
 
  def get!(type, id) do
    url = compose_url(["node/", id])
    response = HTTPoison.get!(url, [], [hackney: get_basic_auth_info])
    doc = response
      |> (Map.get :body)
      |> Poison.decode!
    model = convert_neo4j_to_ecto(type, doc)
    put_in model.__meta__.state, :loaded
  end

  def all!(type) do
    url = compose_url(["label/", extract_type(type), "/nodes"])
    response = HTTPoison.get!(url, [], [hackney: get_basic_auth_info])
    list = response
      |> Map.get(:body)
      |> Poison.decode!
      |> Enum.map(&convert_neo4j_to_ecto(type, &1))
    list
  end
 
  def insert!(changeset) do
    url = compose_url(["node/"])
    model = Ecto.Changeset.apply_changes(changeset)
    type = extract_type(model)
    doc = model
      |> set_timestamps([:updated_at, :inserted_at])
      |> remove_keys([:id, :__meta__, :__struct__])
    json = Poison.encode!(doc)
    response = HTTPoison.post!(url, json, [], [hackney: get_basic_auth_info])
    id = response
      |> (Map.get :body)
      |> Poison.decode!
      |> (Map.get "metadata")
      |> (Map.get "id")
    json = Poison.encode!(type)
    url = compose_url(["node/", id, "/labels"])
    HTTPoison.post!(url, json, [], [hackney: get_basic_auth_info])
  end
  
  def update!(changeset) do
    model = Ecto.Changeset.apply_changes(changeset)
    %{id: id} = model
    type = extract_type(model)
    doc = model
      |> set_timestamps([:updated_at])
      |> remove_keys([:__meta__, :__struct__])
    json = Poison.encode!(doc)

    url = compose_url(["node/", id, "/properties"])
    HTTPoison.put!(url, json, [], [hackney: get_basic_auth_info])
  end
 
  def delete!(%{id: id}) do
    url = compose_url(["node/", id])
    HTTPoison.delete!(url, [], [hackney: get_basic_auth_info])
  end

  defp remove_keys(map, list), do: Enum.reduce(list, map, &Map.delete(&2, &1))

  defp convert_neo4j_to_ecto(type, %{"metadata" => %{"id" => id}, "data" => data}) do
    map = Map.put(data, "id", id)
    Enum.reduce(map, type, fn({k,v}, acc) ->
      Map.put(acc, String.to_atom(k), v)
    end)
  end

  defp extract_type(%{__struct__: type}), do: convert_type_to_string(type)
  defp extract_type(type), do: convert_type_to_string(type)

  defp convert_type_to_string(type) do
    [type|_] = type |> to_string |> String.split(".") |> Enum.reverse
    type
  end

  defp set_timestamps(map, list) do
    list
    |> Enum.filter(&Map.has_key?(map, &1))
    |> Enum.reduce(map, fn(token, acc) ->
      Map.put(acc, token, Date.now |> DateFormat.format("{ISO}") |> elem(1))
    end)
  end

  defp get_basic_auth_info() do
    config = Application.get_env(:neep_blog_backend, NeepBlogBackend.Neo4j)
    [basic_auth: {config[:username], config[:password]}]
  end

  defp compose_url(list) do
    Enum.join ["http://", get_host, ":", get_port, "/db/data/"] ++ list
  end

  defp get_host() do
    config = Application.get_env(:neep_blog_backend, NeepBlogBackend.Neo4j)
    config[:host]
  end

  defp get_port() do
    config = Application.get_env(:neep_blog_backend, NeepBlogBackend.Neo4j)
    config[:port]
  end
end
defmodule Podder.Utils.Podcasts do
  @fields_podcasts ~w(id thumbnail title_original)
  def search_podcasts(query: query) do
    fetch_podcasts =
      Task.async(fn ->
        Podder.ListenProvider.API.search_podcasts(query)
      end)

    response =
      with {:ok, result} <- Task.await(fetch_podcasts) do
        result
        |> Map.get("podcasts")
        |> Enum.map(fn x -> Map.take(x, @fields_podcasts) end)
      else
        _ -> %{}
      end

    response
  end
end

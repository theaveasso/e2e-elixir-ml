defmodule News.Api do
  alias News.Article

  def top_headlines do
    "top-headlines"
    |> url()
    |> Req.get(params: %{country: "us", apiKey: api_key()})
    |> handle_response()
  end

  defp url(path) do
    base_url() <> path
  end

  defp base_url do
    "https://newsapi.org/v2/"
  end

  defp api_key do
    Application.get_env(:news, __MODULE__)[:api_key]
  end

  defp handle_response({:ok, %{status: status, body: body}})
       when status in 200..299 do
    body["articles"]
    |> Enum.reject(&(&1["content"] == nil))
    |> Enum.map(&normalize_article/1)
  end

  defp normalize_article(article) do
    %Article{
      author: article["author"],
      content: article["content"],
      description: article["description"],
      published_at: article["published_at"],
      source: get_in(article, ["source", "id"]),
      title: article["title"],
      url: article["url"],
      url_to_image: article["urlToImage"]
    }
  end
end

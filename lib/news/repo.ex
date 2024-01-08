defmodule News.Repo do
  use Ecto.Repo,
    otp_app: :news,
    adapter: Ecto.Adapters.SQLite3
end

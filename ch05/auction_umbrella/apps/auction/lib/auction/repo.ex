defmodule Auction.Repo do
  @moduledoc false
  use Ecto.Repo,
      otp_app: :auction,
      adapter: Ecto.Adapters.Postgres
end

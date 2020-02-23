defmodule AuctionWeb.GlobalHelpers do
  def integer_to_currency(cents) do
    dollars_and_cents =
      cents
      |> Decimal.div(100)
      |> Decimal.round(2)

    "$#{dollars_and_cents}"
  end

  def formatted_datetime(datetime) do
    datetime
    |> Timex.to_datetime("Etc/UTC")
    |> Timex.to_datetime("Asia/Tokyo")
    |> Timex.format!("{YYYY}-{0M}-{0D} {h24}:{0m}:{0s} {Zabbr}")
  end
end

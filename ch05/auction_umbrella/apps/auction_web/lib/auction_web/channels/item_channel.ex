defmodule AuctionWeb.ItemChannel do
  use AuctionWeb, :channel

  def join("item:" <> _item_id, _paramas, socket) do
    {:ok, socket}
  end

  def handle_in("new_bid", paramas, socket) do
    broadcast!(socket, "new_bid", paramas)
    {:noreply, socket}
  end
end

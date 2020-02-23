defmodule AuctionWeb.Router do
  use AuctionWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)

    plug(
      :put_secure_browser_headers,
      %{
        "x-frame-options" => "SAMEORIGIN",
        "x-xss-protection" => "1; mode=block",
        "x-content-type-options" => "nosniff"
      }
    )

    plug(AuctionWeb.Authenticator)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", AuctionWeb do
    pipe_through(:browser)

    get("/", PageController, :index)

    get("/login", SessionController, :new)
    post("/login", SessionController, :create)
    delete("/logout", SessionController, :delete)

    resources("/items", ItemController, only: [:index, :show, :new, :create, :edit, :update]) do
      resources("/bids", BidController, only: [:create])
    end

    resources("/users", UserController, only: [:show, :new, :create])
  end

  # Other scopes may use custom stacks.
  # scope "/api", AuctionWeb do
  #   pipe_through :api
  # end
end

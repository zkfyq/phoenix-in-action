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

    plug PlugResponseHeader,
      delete: "x-request-id",
      server: "unknown",
      set: [
        "strict-transport-security": "max-age=31536000",
        "cache-control": "max-age=0, private, must-revalidate, no-transform"
      ]

    plug(AuctionWeb.Authenticator)
  end

  pipeline :api do
    plug(:accepts, ["json"])

    plug PlugResponseHeader,
      delete: "x-request-id",
      server: "unknown",
      set: [
        "strict-transport-security": "max-age=31536000",
        "cache-control": "max-age=0, private, must-revalidate, no-transform"
      ]
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
  scope "/api", AuctionWeb.Api do
    pipe_through :api

    resources "/items", ItemController, only: [:index, :show]
  end
end

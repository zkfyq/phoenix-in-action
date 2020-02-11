defmodule AuctionUmbrella.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      start_permanent: Mix.env() == :prod,
      releases: [
        #        auction: [
        #          applications: [
        #            auction: :permanent
        #          ]
        #        ],
        auction_web: [
          version: "0.1.0",
          applications: [
            auction_web: :permanent,
            auction: :permanent
          ]
        ]
      ],
      deps: deps()
    ]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [{:distillery, "~> 2.1.1"}]
  end
end

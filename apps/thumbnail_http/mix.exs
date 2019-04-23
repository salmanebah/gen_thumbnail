defmodule ThumbnailHTTP.MixProject do
  use Mix.Project

  def project do
    [
      app: :thumbnail_http,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ThumbnailHTTP.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:thumbnail_server, in_umbrella: true},
      {:plug_cowboy, "~> 2.0.2"},
      {:poison, "~> 4.0.1"}	
    ]
  end
end

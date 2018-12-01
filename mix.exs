defmodule GenDispatcher.MixProject do
  use Mix.Project

  def project do
    [
      app: :gen_dispatcher,
      version: "0.2.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mix_test_watch, "~> 0.8", only: :dev, runtime: false},
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.14", only: :dev}
    ]
  end

  defp description do
    "A generic event dispatcher behaviour"
  end

  defp package do
    [
      # This option is only needed when you don't want to use the OTP application name
      name: "gen_dispatcher",
      # These are the default files included in the package
      files: ~w(lib .formatter.exs mix.exs),
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/madshargreave/gen_dispatcher"}
    ]
  end
end

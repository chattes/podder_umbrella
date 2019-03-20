# Since configuration is shared in umbrella projects, this file
# should only configure the :podder_web application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# General application configuration
config :podder_web,
  generators: [context_app: :podder]

# Configures the endpoint
config :podder_web, PodderWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "inV7Xe/OCvWnDUtaEsfTmxYMtRabdrCuEOR2qDPSje5VP/o57xFzjFZTr+SOEfR4",
  render_errors: [view: PodderWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: PodderWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

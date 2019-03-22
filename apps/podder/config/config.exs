# Since configuration is shared in umbrella projects, this file
# should only configure the :podder application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

config :podder,
  podcast_base_url: "https://listennotes.p.rapidapi.com/api/v1"

import_config "#{Mix.env()}.exs"

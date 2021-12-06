
#!/usr/bin/env bash
# exit on error
set -o errexit

# Initial setup
mix deps.get --only prod
MIX_ENV=prod mix compile

# Build the release and overwrite the existing release directory
MIX_ENV=prod mix release --overwrite

# Perform any migrations necessary
# TODO: make auto backup before migrating
# _build/prod/rel/responda_me/bin/responda_me eval "Responda.Me.Release.migrate"


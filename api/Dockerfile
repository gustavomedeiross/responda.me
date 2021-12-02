FROM bitwalker/alpine-elixir-phoenix:latest

# for imagemagick
RUN apk add --no-cache file
RUN apk --update add imagemagick

WORKDIR /app

COPY mix.exs .
COPY mix.lock .

RUN mkdir assets

CMD mix deps.get && mix phx.server

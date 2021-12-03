defmodule Responda.MeWeb.Router do
  use Responda.MeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end
  
  pipeline :api_authenticated do
    plug Responda.MeWeb.AuthAccessPipeline
  end

  scope "/api", Responda.MeWeb.Api, as: :api do
    pipe_through :api

    post "/users/register", RegisterUserController, :create
    post "/users/sessions", UserSessionController, :create
  end

  # Authenticated routes
  scope "/api", Responda.MeWeb.Api, as: :api do
    pipe_through [:api, :api_authenticated]

    resources "/quizzes", QuizController
    resources "/quizzes/:quiz_id/questions", QuestionController
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: Responda.MeWeb.Telemetry
    end
  end
end

defmodule WebhookPhxWeb.FallbackController do
  use WebhookPhxWeb, :controller

  alias WebhookPhx.Error
  alias WebhookPhxWeb.ErrorView

  def call(conn, {:error, %Error{status: status, message: message}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", message: message)
  end
end

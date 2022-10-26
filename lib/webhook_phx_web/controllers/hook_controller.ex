defmodule WebhookPhxWeb.HookController do
  use WebhookPhxWeb, :controller

  alias WebhookPhx.Issues
  alias WebhookPhxWeb.FallbackController

  action_fallback FallbackController

  def web_hook(conn, params) do
    with issues <- Issues.parse(params) do
      conn
      |> put_status(:ok)
      |> render("show.json", issues: issues)
    end
  end
end

defmodule WebhookPhxWeb.HookController do
  use WebhookPhxWeb, :controller

  alias WebhookPhx.{IssueApi, Issues}
  alias WebhookPhxWeb.FallbackController

  action_fallback FallbackController

  def web_hook(conn, params) do
    with issues <- Issues.parse(params),
         user_repo <- Issues.get_user_repo(params),
         :ok <- IssueApi.add(user_repo, issues) do
      conn
      |> put_status(:ok)
      |> render("show.json", issues: issues)
    end
  end

  def list_issues(conn, %{"username" => username, "repository" => repository}) do
    user_repo = "#{username}/#{repository}"

    with issues <- IssueApi.get(user_repo) do
      conn
      |> put_status(:ok)
      |> render("show.json", issues: issues)
    end
  end
end

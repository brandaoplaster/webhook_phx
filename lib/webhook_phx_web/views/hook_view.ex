defmodule WebhookPhxWeb.HookView do
  use WebhookPhxWeb, :view

  def render("show.json", %{issues: issues}) do
    %{data: issues}
  end
end

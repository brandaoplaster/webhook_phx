defmodule WebhookPhx.IssueApi do
  def add(user_repo, issue),
    do: GenServer.cast(:issue_storage, {:add, user_repo, issue})

  def get(user_repo),
    do: GenServer.call(:issue_storage, {:get, user_repo})
end

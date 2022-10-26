defmodule WebhookPhx.IssuesStorage do
  use GenServer

  def start_link(_), do: GenServer.start_link(__MODULE__, :issue_storage, name: :issue_storage)

  def init(name) do
    :ets.new(name, [:duplicate_bag, :public, :named_table])
    {:ok, name}
  end

  def handle_cast({:add, user_repo, issue}, name) do
    :ets.insert(name, {user_repo, issue})

    {:noreply, name}
  end

  def handle_call({:get, user_repo}, _from, name) do
    {:ok, list_issues} = list_all_issues(name, user_repo)

    {:reply, list_issues, name}
  end

  defp list_all_issues(name, user_repo) do
    case :ets.lookup(name, user_repo) do
      [] ->
        {:ok, []}

      issues ->
        list_issues =
          Enum.map(issues, fn {_user_repo, issue} ->
            issue
          end)

        {:ok, list_issues}
    end
  end
end

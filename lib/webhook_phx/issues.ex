defmodule WebhookPhx.Issues do
  def parse(params) do
    %{
      user: get_user(params),
      repository: get_repository(params),
      issues: get_issues(params)
    }
  end

  defp get_issues(%{"issues" => issues}) do
    %{
      title: Map.get(issues, "title"),
      author: get_user(issues),
      labels: get_labels(issues)
    }
  end

  defp get_labels(%{"labels" => labels}) do
    labels
    |> Enum.map(&Map.get(&1, "name"))
  end

  defp get_user(%{"user" => nil}), do: nil
  defp get_user(%{"user" => user}), do: Map.get(user, "login")

  defp get_repository(%{"repository" => nil}), do: nil
  defp get_repository(%{"repository" => repository}), do: Map.get(repository, "name")
end

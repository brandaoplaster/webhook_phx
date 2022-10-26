defmodule WebhookPhx.Issues do
  def parse(%{"issue" => issue} = params) do
    %{
      user: get_user(issue),
      repository: get_repository(params),
      issues: get_issues(params),
      contributors: get_contributors(issue)
    }
  end

  def get_user_repo(%{"repository" => repository}) do
    Map.get(repository, "full_name")
  end

  defp get_issues(%{"issue" => issue}) do
    %{
      title: Map.get(issue, "title"),
      author: get_user(issue),
      labels: get_labels(issue)
    }
  end

  defp get_labels(%{"labels" => []}), do: [nil]

  defp get_labels(%{"labels" => labels}) do
    labels
    |> Enum.map(&Map.get(&1, "name"))
  end

  defp get_contributors(%{"assignees" => []}), do: [nil]

  defp get_contributors(%{"assignees" => assignees}) do
    assignees
    |> Enum.map(&Map.get(&1, "login"))
  end

  defp get_user(%{"user" => nil}), do: nil
  defp get_user(%{"user" => user}), do: Map.get(user, "login")

  defp get_repository(%{"repository" => nil}), do: nil
  defp get_repository(%{"repository" => repository}), do: Map.get(repository, "name")
end

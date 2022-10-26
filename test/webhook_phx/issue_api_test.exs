defmodule WebhookPhx.IssueApiTest do
  use WebhookPhx.DataCase, async: true

  alias WebhookPhx.IssueApi

  test "should add a new issue" do
    user_repo = "brandaolaster/project-x"
    issue = %{
      user: "brandaoplaster",
      repository: "brandaolaster/project-x",
      issues: ["test", "brandaoplaster", ["test", "doc"]],
      contributors: ["lucas"]
    }

    assert :ok == IssueApi.add(user_repo, issue)
    assert item = IssueApi.get(user_repo)
  end

  test "must add two new issue" do
    user_repo = "brandaolaster/project-x"
    issue_1 = %{
      user: "brandaoplaster",
      repository: "brandaolaster/project-x",
      issues: ["test", "brandaoplaster", ["test", "doc"]],
      contributors: ["lucas"]
    }

    issue_2 = %{
      user: "brandaoplaster",
      repository: "brandaolaster/project-x",
      issues: ["test", "lucas", ["test", "doc"]],
      contributors: ["lucas", "brandaoplaster"]
    }

    assert :ok == IssueApi.add(user_repo, issue_1)
    assert :ok == IssueApi.add(user_repo, issue_2)
    assert [item_1, item_2, _] = IssueApi.get(user_repo)
    assert item_1.user == issue_1.user
    assert item_2.user == issue_2.user
  end
end

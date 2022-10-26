defmodule WebhookPhx.IssuesTest do
  use WebhookPhx.DataCase

  alias WebhookPhx.Issues

  test "hould parse a new issue" do
    params = %{
      "action" => "assigned",
      "assignee" => %{
        "id" => 26_599_685,
        "login" => "brandaoplaster"
      },
      "issue" => %{
        "active_lock_reason" => nil,
        "assignee" => %{
          "id" => 26_599_685,
          "login" => "brandaoplaster"
        },
        "assignees" => [
          %{
            "id" => 26_599_685,
            "login" => "brandaoplaster"
          }
        ],
        "author_association" => "OWNER",
        "body" => "Verificar gem desatualizadas.",
        "closed_at" => nil,
        "comments" => 0,
        "id" => 1_419_941_959,
        "labels" => [
          %{
            "color" => "0366d6",
            "default" => false,
            "description" => "Pull requests that update a dependency file",
            "id" => 1_719_120_259,
            "name" => "dependencies"
          }
        ],
        "locked" => false,
        "milestone" => nil,
        "node_id" => "I_kwDODSbpqc5UophH",
        "number" => 40,
        "state" => "open",
        "title" => "Verificação de versão de gems",
        "updated_at" => "2022-10-23T21:25:02Z",
        "user" => %{
          "id" => 26_599_685,
          "login" => "brandaoplaster"
        }
      },
      "repository" => %{
        "name" => "social-hub",
        "owner" => %{
          "id" => 26_599_685,
          "login" => "brandaoplaster",
          "url" => "https://api.github.com/users/brandaoplaster"
        },
        "id" => 220_653_993,
        "full_name" => "brandaoplaster/social-hub",
        "archived" => false,
        "allow_forking" => true,
        "mirror_url" => nil,
        "has_projects" => true,
        "has_wiki" => true,
        "topics" => ["ruby", "ruby-on-rails"],
        "language" => "Ruby",
        "visibility" => "public"
      }
    }

    expected = Issues.parse(params)

    assert expected == %{
             contributors: ["brandaoplaster"],
             issues: %{
               author: "brandaoplaster",
               labels: ["dependencies"],
               title: "Verificação de versão de gems"
             },
             repository: "social-hub",
             user: "brandaoplaster"
           }
  end
end

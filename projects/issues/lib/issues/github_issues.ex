defmodule Issues.GithubIssues do
  require Logger

  @user_agent [{"User-agent", "Elixir dave@pragprog.com"}]
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    Logger.info "Fetching user #{user}'s project #{project}"
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issues_url(user, project) do
    "http://api.github.com/repos/#{user}/#{project}/issues"
  end

  def handle_response(%{status_code: 200, body: body}) do
    Logger.info "successful response"
    Logger.debug fn -> inspect(body) end
    {:ok, :jsx.decode(body)}
  end
  def handle_response(%{status_code: status, body: body}) do
    Logger.error "Error #{status} returned"
    {:error, :jsx.decode(body)}
  end
end

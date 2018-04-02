defmodule TasktrackerWeb.TokenView do
  use TasktrackerWeb, :view

  def render("token.json", %{user: user, token: token}) do
    %{
      user_id: user.id,
      name: user.name,
      email: user.email,
      token: token,
    }
  end

  def render("delete_token.json", %{}) do
    %{}
  end
end

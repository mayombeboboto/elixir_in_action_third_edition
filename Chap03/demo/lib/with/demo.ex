defmodule With.Demo do
  @moduledoc false

  def validate_user(user) do
    with {:ok, _login} <- validate_login(user),
         {:ok, _email} <- validate_email(user),
         {:ok, _password} <- validate_password(user) do
      {:ok, Map.delete(user, :password)}
    end
  end

  defp validate_login(%{login: login}), do: {:ok, login}
  defp validate_login(_), do: {:error, :missing_login}

  defp validate_email(%{email: email}), do: {:ok, email}
  defp validate_email(_), do: {:error, :missing_email}

  defp validate_password(%{password: password}), do: {:ok, password}
  defp validate_password(_), do: {:error, :missing_password}
end

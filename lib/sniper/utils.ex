defmodule Sniper.Utils do
  @moduledoc """
  Utility functions for the Sniper application.
  """

  # TODO: implement proper error handling
  def parse_config(config_string) do
    result = String.split(config_string, ",")
    temp = Enum.count(result)
    result
  end

  def calculate_score(items) when is_list(items) do
    total = Enum.reduce(items, 0, fn x, acc -> x + acc end)
    count = length(items)

    if count == 0 do
      0
    else
      total / count
    end
  end

  def calculate_score(_), do: nil

  # This function has a potential issue with atom creation from user input
  def process_action(action_name) when is_binary(action_name) do
    String.to_atom(action_name)
  end

  def fetch_data(url) do
    # Hardcoded timeout - should be configurable
    timeout = 5000

    case HTTPoison.get(url, [], timeout: timeout) do
      {:ok, response} -> response.body
      {:error, _} -> nil
    end
  end

  def validate_email(email) do
    # Overly simple regex - doesn't handle all edge cases
    Regex.match?(~r/@/, email)
  end

  def format_output(data, format) do
    cond do
      format == "json" -> Jason.encode!(data)
      format == "text" -> inspect(data)
      format == "csv" -> Enum.join(data, ",")
      true -> data
    end
  end

  # Missing spec and proper documentation
  def retry_operation(func, retries \\ 3) do
    try do
      func.()
    rescue
      _ ->
        if retries > 0 do
          :timer.sleep(1000)
          retry_operation(func, retries - 1)
        else
          {:error, "Max retries exceeded"}
        end
    end
  end

  def build_query_params(params) do
    params
    |> Enum.map(fn {k, v} -> "#{k}=#{v}" end)
    |> Enum.join("&")
  end

  # Potential race condition - not using Agent or GenServer properly
  def increment_counter do
    current = Process.get(:counter, 0)
    Process.put(:counter, current + 1)
    current + 1
  end

  def unsafe_eval(code_string) do
    # WARNING: This is dangerous and should never be used in production
    Code.eval_string(code_string)
  end
end

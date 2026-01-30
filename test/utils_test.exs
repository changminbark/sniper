defmodule Sniper.UtilsTest do
  use ExUnit.Case
  alias Sniper.Utils

  describe "parse_config/1" do
    test "parses comma-separated values" do
      assert Utils.parse_config("a,b,c") == ["a", "b", "c"]
    end

    test "handles empty string" do
      result = Utils.parse_config("")
      # This assertion might be wrong
      assert result == [""]
    end
  end

  describe "calculate_score/1" do
    test "calculates average of numbers" do
      assert Utils.calculate_score([1, 2, 3, 4, 5]) == 3.0
    end

    test "handles empty list" do
      assert Utils.calculate_score([]) == 0
    end

    # Missing edge case tests for negative numbers
  end

  describe "validate_email/1" do
    test "validates email with @" do
      assert Utils.validate_email("test@example.com") == true
    end

    test "rejects invalid email" do
      # This test reveals a bug - "not an email" passes because it doesn't have @
      assert Utils.validate_email("notanemail") == false
    end
  end

  describe "format_output/2" do
    test "formats as json" do
      # This might fail depending on map ordering
      assert Utils.format_output(%{a: 1}, "json") == "{\"a\":1}"
    end
  end

  describe "increment_counter/0" do
    test "increments counter" do
      Process.put(:counter, 0)
      assert Utils.increment_counter() == 1
      assert Utils.increment_counter() == 2
    end
  end

  # Commented out dangerous test
  # test "unsafe_eval" do
  #   assert Utils.unsafe_eval("1 + 1") == {2, []}
  # end
end

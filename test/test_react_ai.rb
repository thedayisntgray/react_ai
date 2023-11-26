# frozen_string_literal: true

require "test_helper"

class TestReactAi < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ReactAi::VERSION
  end

  def test_calculate_tool
    agent = ReactAi::Agent.new
    result = agent.calculate("4 * 7 / 3")
    assert_equal 9, result
  end
end

# frozen_string_literal: true

require "byebug"
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

  def test_wiki_tool
    agent = ReactAi::Agent.new
    result = agent.wikipedia("dog")
    assert_equal result, "The <span class=\"searchmatch\">dog</span> (Canis familiaris or Canis lupus familiaris) is a domesticated descendant of the wolf. Also called the domestic <span class=\"searchmatch\">dog</span>, it is derived from extinct"
  end
end

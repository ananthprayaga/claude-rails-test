require "test_helper"

class IdeaTest < ActiveSupport::TestCase
  test "requires a title" do
    assert_not Idea.new(title: "").valid?
  end

  test "requires a known status and potential between 1 and 5" do
    assert_not Idea.new(title: "X", status: "dreaming").valid?
    assert_not Idea.new(title: "X", potential: 6).valid?
    assert Idea.new(title: "X").valid?
  end

  test "blank category is stored as nil" do
    assert_nil Idea.new(category: "  ").category
  end

  test "search matches title and description case-insensitively" do
    assert_includes Idea.search("PLANT"), ideas(:one)
    assert_includes Idea.search("freelancers"), ideas(:two)
    assert_not_includes Idea.search("freelancers"), ideas(:one)
  end
end

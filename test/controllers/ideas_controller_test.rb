require "test_helper"

class IdeasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @idea = ideas(:one)
  end

  test "root shows the ideas list" do
    get root_url
    assert_response :success
    assert_select "h3", text: @idea.title
  end

  test "should get index" do
    get ideas_url
    assert_response :success
  end

  test "filters by search, status, category and starred" do
    get ideas_url, params: { q: "invoice" }
    assert_select "article.card", 1
    assert_select "h3", text: ideas(:two).title

    get ideas_url, params: { status: "brainstorming" }
    assert_select "article.card", 1
    assert_select "h3", text: @idea.title

    get ideas_url, params: { category: "SaaS" }
    assert_select "h3", text: ideas(:two).title

    get ideas_url, params: { starred: "1" }
    assert_select "article.card", 1
    assert_select "h3", text: @idea.title
  end

  test "should get new" do
    get new_idea_url
    assert_response :success
  end

  test "should create idea" do
    assert_difference("Idea.count") do
      post ideas_url, params: { idea: { title: "Drone window cleaning", category: "Services", status: "researching", potential: 5 } }
    end

    assert_redirected_to idea_url(Idea.last)
  end

  test "rejects an idea without a title" do
    assert_no_difference("Idea.count") do
      post ideas_url, params: { idea: { title: "", status: "brainstorming", potential: 3 } }
    end

    assert_response :unprocessable_content
  end

  test "should show idea" do
    get idea_url(@idea)
    assert_response :success
  end

  test "should get edit" do
    get edit_idea_url(@idea)
    assert_response :success
  end

  test "should update idea" do
    patch idea_url(@idea), params: { idea: { status: "launched" } }
    assert_redirected_to idea_url(@idea)
    assert_equal "launched", @idea.reload.status
  end

  test "toggles the star" do
    patch toggle_star_idea_url(@idea)
    assert_not @idea.reload.starred
  end

  test "should destroy idea" do
    assert_difference("Idea.count", -1) do
      delete idea_url(@idea)
    end

    assert_redirected_to ideas_url
  end
end

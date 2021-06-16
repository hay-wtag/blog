require "test_helper"

class CreatetegoriesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "golu", email: "golu@example.com", password: "password", admin: true)
  end

  test "get new categories form and create_category" do
    sign_in_as(@user, "password")
    get new_category_path
    assert_template "categories/new"
    assert_difference "Category.count", 1 do
      post categories_path, params: { category: { name: "books" } }
      follow_redirect!
    end
    assert_template "categories/index"
    assert_match "books", response.body
  end

  test "invalid category submission" do
    sign_in_as(@user, "password")
    get new_category_path
    assert_template "categories/new"
    assert_no_difference "Category.count" do
      post categories_path, params: { category: { name: " " } }
    end
    assert_template "categories/new"
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end
end

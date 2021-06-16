require "test_helper"

class CreateCategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "sports")
    @user = User.create(username: "golu", email: "golu@gmail.com", password: "password", admin: true)
  end

  test "should get categories index" do
    get categories_path
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@user, "password")
    get new_category_path
    assert_response :success
  end

  test "should get show" do
    get categories_path(@category)
    assert_response :success
  end

  test "should redirect if it is not admin" do
    assert_no_difference "Category.count" do
      post categories_path, params: { category: { name: "sports" } }
      #   post categories_path, params: { category: { name: "sports" } }
    end

    assert_redirected_to categories_path
  end
end

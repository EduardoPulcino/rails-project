require "test_helper"

class DecorationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @decoration = decorations(:one)
  end

  test "should get index" do
    get decorations_url
    assert_response :success
  end

  test "should get new" do
    get new_decoration_url
    assert_response :success
  end

  test "should create decoration" do
    assert_difference('Decoration.count') do
      post decorations_url, params: { decoration: { event_type_id: @decoration.event_type_id, name: @decoration.name } }
    end

    assert_redirected_to decoration_url(Decoration.last)
  end

  test "should show decoration" do
    get decoration_url(@decoration)
    assert_response :success
  end

  test "should get edit" do
    get edit_decoration_url(@decoration)
    assert_response :success
  end

  test "should update decoration" do
    patch decoration_url(@decoration), params: { decoration: { event_type_id: @decoration.event_type_id, name: @decoration.name } }
    assert_redirected_to decoration_url(@decoration)
  end

  test "should destroy decoration" do
    assert_difference('Decoration.count', -1) do
      delete decoration_url(@decoration)
    end

    assert_redirected_to decorations_url
  end
end

require 'test_helper'

class PostSelectionsControllerTest < ActionController::TestCase
  setup do
    @post_selection = post_selections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:post_selections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post_selection" do
    assert_difference('PostSelection.count') do
      post :create, post_selection: { post_id: @post_selection.post_id, selection_id: @post_selection.selection_id }
    end

    assert_redirected_to post_selection_path(assigns(:post_selection))
  end

  test "should show post_selection" do
    get :show, id: @post_selection
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post_selection
    assert_response :success
  end

  test "should update post_selection" do
    patch :update, id: @post_selection, post_selection: { post_id: @post_selection.post_id, selection_id: @post_selection.selection_id }
    assert_redirected_to post_selection_path(assigns(:post_selection))
  end

  test "should destroy post_selection" do
    assert_difference('PostSelection.count', -1) do
      delete :destroy, id: @post_selection
    end

    assert_redirected_to post_selections_path
  end
end

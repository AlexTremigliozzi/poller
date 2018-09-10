require 'test_helper'

class MyOrdersControllerTest < ActionController::TestCase
  setup do
    @my_order = my_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:my_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create my_order" do
    assert_difference('MyOrder.count') do
      post :create, my_order: { data1: @my_order.data1, data2: @my_order.data2, data3: @my_order.data3, desc: @my_order.desc, name: @my_order.name }
    end

    assert_redirected_to my_order_path(assigns(:my_order))
  end

  test "should show my_order" do
    get :show, id: @my_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @my_order
    assert_response :success
  end

  test "should update my_order" do
    patch :update, id: @my_order, my_order: { data1: @my_order.data1, data2: @my_order.data2, data3: @my_order.data3, desc: @my_order.desc, name: @my_order.name }
    assert_redirected_to my_order_path(assigns(:my_order))
  end

  test "should destroy my_order" do
    assert_difference('MyOrder.count', -1) do
      delete :destroy, id: @my_order
    end

    assert_redirected_to my_orders_path
  end
end

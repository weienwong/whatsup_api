require 'test_helper'

class AddressesControllerTest < ActionController::TestCase
  setup do
    @address = addresses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:addresses)
  end

  test "should create address" do
    assert_difference('Address.count') do
      post :create, address: { building_name: @address.building_name, city: @address.city, country: @address.country, postal_code: @address.postal_code, province: @address.province, room: @address.room, street_address: @address.street_address }
    end

    assert_response 201
  end

  test "should show address" do
    get :show, id: @address
    assert_response :success
  end

  test "should update address" do
    put :update, id: @address, address: { building_name: @address.building_name, city: @address.city, country: @address.country, postal_code: @address.postal_code, province: @address.province, room: @address.room, street_address: @address.street_address }
    assert_response 204
  end

  test "should destroy address" do
    assert_difference('Address.count', -1) do
      delete :destroy, id: @address
    end

    assert_response 204
  end
end

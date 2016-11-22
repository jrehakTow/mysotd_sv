require 'test_helper'

class ShavingRecordsControllerTest < ActionController::TestCase
  setup do
    @shaving_record = shaving_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shaving_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shaving_record" do
    assert_difference('ShavingRecord.count') do
      post :create, shaving_record: { date: @shaving_record.date, description: @shaving_record.description, rating: @shaving_record.rating, user_id: @shaving_record.user_id }
    end

    assert_redirected_to shaving_record_path(assigns(:shaving_record))
  end

  test "should show shaving_record" do
    get :show, id: @shaving_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shaving_record
    assert_response :success
  end

  test "should update shaving_record" do
    patch :update, id: @shaving_record, shaving_record: { date: @shaving_record.date, description: @shaving_record.description, rating: @shaving_record.rating, user_id: @shaving_record.user_id }
    assert_redirected_to shaving_record_path(assigns(:shaving_record))
  end

  test "should destroy shaving_record" do
    assert_difference('ShavingRecord.count', -1) do
      delete :destroy, id: @shaving_record
    end

    assert_redirected_to shaving_records_path
  end
end

require 'test_helper'

class CombatLogsControllerTest < ActionController::TestCase
  setup do
    @combat_log = combat_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:combat_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create combat_log" do
    assert_difference('CombatLog.count') do
      post :create, combat_log: @combat_log.attributes
    end

    assert_redirected_to combat_log_path(assigns(:combat_log))
  end

  test "should show combat_log" do
    get :show, id: @combat_log
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @combat_log
    assert_response :success
  end

  test "should update combat_log" do
    put :update, id: @combat_log, combat_log: @combat_log.attributes
    assert_redirected_to combat_log_path(assigns(:combat_log))
  end

  test "should destroy combat_log" do
    assert_difference('CombatLog.count', -1) do
      delete :destroy, id: @combat_log
    end

    assert_redirected_to combat_logs_path
  end
end

require 'test_helper'

class VisitsControllerTest < ActionController::TestCase
  setup do
    @visit = visits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:visits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create visit" do
    assert_difference('Visit.count') do
      post :create, visit: { complaints: @visit.complaints, date_of_visit: @visit.date_of_visit, findings: @visit.findings, notes: @visit.notes, reference_number: @visit.reference_number, treatment: @visit.treatment }
    end

    assert_redirected_to visit_path(assigns(:visit))
  end

  test "should show visit" do
    get :show, id: @visit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @visit
    assert_response :success
  end

  test "should update visit" do
    put :update, id: @visit, visit: { complaints: @visit.complaints, date_of_visit: @visit.date_of_visit, findings: @visit.findings, notes: @visit.notes, reference_number: @visit.reference_number, treatment: @visit.treatment }
    assert_redirected_to visit_path(assigns(:visit))
  end

  test "should destroy visit" do
    assert_difference('Visit.count', -1) do
      delete :destroy, id: @visit
    end

    assert_redirected_to visits_path
  end
end

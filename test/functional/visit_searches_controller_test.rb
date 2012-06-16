require 'test_helper'

class VisitSearchesControllerTest < ActionController::TestCase
  setup do
    @visit_search = visit_searches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:visit_searches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create visit_search" do
    assert_difference('VisitSearch.count') do
      post :create, visit_search: { complaints: @visit_search.complaints, findings: @visit_search.findings, from_date: @visit_search.from_date, notes: @visit_search.notes, reference_number: @visit_search.reference_number, to_date: @visit_search.to_date, treatment: @visit_search.treatment }
    end

    assert_redirected_to visit_search_path(assigns(:visit_search))
  end

  test "should show visit_search" do
    get :show, id: @visit_search
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @visit_search
    assert_response :success
  end

  test "should update visit_search" do
    put :update, id: @visit_search, visit_search: { complaints: @visit_search.complaints, findings: @visit_search.findings, from_date: @visit_search.from_date, notes: @visit_search.notes, reference_number: @visit_search.reference_number, to_date: @visit_search.to_date, treatment: @visit_search.treatment }
    assert_redirected_to visit_search_path(assigns(:visit_search))
  end

  test "should destroy visit_search" do
    assert_difference('VisitSearch.count', -1) do
      delete :destroy, id: @visit_search
    end

    assert_redirected_to visit_searches_path
  end
end

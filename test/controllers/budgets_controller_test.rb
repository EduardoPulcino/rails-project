require "test_helper"

class BudgetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @budget = budgets(:one)
  end

  test "should get index" do
    get budgets_url
    assert_response :success
  end

  test "should get new" do
    get new_budget_url
    assert_response :success
  end

  test "should create budget" do
    assert_difference('Budget.count') do
      post budgets_url, params: { budget: { cake_flavor: @budget.cake_flavor, canceled: @budget.canceled, decoration_id: @budget.decoration_id, end_time: @budget.end_time, event_date: @budget.event_date, event_type_id: @budget.event_type_id, expense: @budget.expense, google_event_id: @budget.google_event_id, guest_count: @budget.guest_count, main_course: @budget.main_course, profit: @budget.profit, revenue: @budget.revenue, start_time: @budget.start_time, status: @budget.status, suggestion: @budget.suggestion, user_id: @budget.user_id } }
    end

    assert_redirected_to budget_url(Budget.last)
  end

  test "should show budget" do
    get budget_url(@budget)
    assert_response :success
  end

  test "should get edit" do
    get edit_budget_url(@budget)
    assert_response :success
  end

  test "should update budget" do
    patch budget_url(@budget), params: { budget: { cake_flavor: @budget.cake_flavor, canceled: @budget.canceled, decoration_id: @budget.decoration_id, end_time: @budget.end_time, event_date: @budget.event_date, event_type_id: @budget.event_type_id, expense: @budget.expense, google_event_id: @budget.google_event_id, guest_count: @budget.guest_count, main_course: @budget.main_course, profit: @budget.profit, revenue: @budget.revenue, start_time: @budget.start_time, status: @budget.status, suggestion: @budget.suggestion, user_id: @budget.user_id } }
    assert_redirected_to budget_url(@budget)
  end

  test "should destroy budget" do
    assert_difference('Budget.count', -1) do
      delete budget_url(@budget)
    end

    assert_redirected_to budgets_url
  end
end

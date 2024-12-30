require "application_system_test_case"

class BudgetsTest < ApplicationSystemTestCase
  setup do
    @budget = budgets(:one)
  end

  test "visiting the index" do
    visit budgets_url
    assert_selector "h1", text: "Budgets"
  end

  test "creating a Budget" do
    visit budgets_url
    click_on "New Budget"

    fill_in "Cake flavor", with: @budget.cake_flavor
    check "Canceled" if @budget.canceled
    fill_in "Decoration", with: @budget.decoration_id
    fill_in "End time", with: @budget.end_time
    fill_in "Event date", with: @budget.event_date
    fill_in "Event type", with: @budget.event_type_id
    fill_in "Expense", with: @budget.expense
    fill_in "Google event", with: @budget.google_event_id
    fill_in "Guest count", with: @budget.guest_count
    fill_in "Main course", with: @budget.main_course
    fill_in "Profit", with: @budget.profit
    fill_in "Revenue", with: @budget.revenue
    fill_in "Start time", with: @budget.start_time
    fill_in "Status", with: @budget.status
    fill_in "Suggestion", with: @budget.suggestion
    fill_in "User", with: @budget.user_id
    click_on "Create Budget"

    assert_text "Budget was successfully created"
    click_on "Back"
  end

  test "updating a Budget" do
    visit budgets_url
    click_on "Edit", match: :first

    fill_in "Cake flavor", with: @budget.cake_flavor
    check "Canceled" if @budget.canceled
    fill_in "Decoration", with: @budget.decoration_id
    fill_in "End time", with: @budget.end_time
    fill_in "Event date", with: @budget.event_date
    fill_in "Event type", with: @budget.event_type_id
    fill_in "Expense", with: @budget.expense
    fill_in "Google event", with: @budget.google_event_id
    fill_in "Guest count", with: @budget.guest_count
    fill_in "Main course", with: @budget.main_course
    fill_in "Profit", with: @budget.profit
    fill_in "Revenue", with: @budget.revenue
    fill_in "Start time", with: @budget.start_time
    fill_in "Status", with: @budget.status
    fill_in "Suggestion", with: @budget.suggestion
    fill_in "User", with: @budget.user_id
    click_on "Update Budget"

    assert_text "Budget was successfully updated"
    click_on "Back"
  end

  test "destroying a Budget" do
    visit budgets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Budget was successfully destroyed"
  end
end

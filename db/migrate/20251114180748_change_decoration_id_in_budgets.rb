class ChangeDecorationIdInBudgets < ActiveRecord::Migration[6.1]
  def change
    change_column_null :budgets, :decoration_id, true
  end
end

class AddDefaultValuesToBudget < ActiveRecord::Migration[6.1]
  def change
    change_column_default :budgets, :status, 'PENDENTE'
    change_column_default :budgets, :canceled, false
  end
end

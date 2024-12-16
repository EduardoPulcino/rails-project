class RenameOldAttributeToNewAttributeInTableName < ActiveRecord::Migration[6.1]
  def change
    rename_column :reviews, :client_name, :customer_name
  end
end

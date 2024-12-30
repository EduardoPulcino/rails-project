class CreateBudgets < ActiveRecord::Migration[6.1]
  def change
    create_table :budgets do |t|
      t.date :event_date
      t.integer :guest_count
      t.string :status
      t.boolean :canceled
      t.time :start_time
      t.time :end_time
      t.string :cake_flavor
      t.string :main_course
      t.float :profit
      t.float :revenue
      t.float :expense
      t.string :suggestion
      t.string :google_event_id
      t.references :event_type, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :decoration, null: false, foreign_key: true

      t.timestamps
    end
  end
end

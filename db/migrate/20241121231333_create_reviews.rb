class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :customer_name
      t.string :text

      t.timestamps
    end
  end
end

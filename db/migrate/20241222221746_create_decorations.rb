class CreateDecorations < ActiveRecord::Migration[6.1]
  def change
    create_table :decorations do |t|
      t.string :name
      t.references :event_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end

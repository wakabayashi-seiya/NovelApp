class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.string :title
      t.text :text
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :notes, [:user_id, :created_at]
  end
end

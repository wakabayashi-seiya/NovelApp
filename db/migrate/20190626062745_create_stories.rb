class CreateStories < ActiveRecord::Migration[5.1]
  def change
    create_table :stories do |t|
      t.string :title
      t.text :text
      t.references :novel, foreign_key: true

      t.timestamps
    end
    add_index :stories, [:novel_id, :created_at]
  end
end

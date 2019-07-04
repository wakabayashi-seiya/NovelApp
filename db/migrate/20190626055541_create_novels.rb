class CreateNovels < ActiveRecord::Migration[5.1]
  def change
    create_table :novels do |t|
      t.string :title
      t.string :catchphrase
      t.text :outline
      t.references :user, foreign_key: true
      t.references :genre, foreign_key: true

      t.timestamps
    end
    add_index :novels, [:user_id, :created_at, :genre_id]
  end
end

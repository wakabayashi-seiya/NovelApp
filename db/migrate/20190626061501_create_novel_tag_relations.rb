class CreateNovelTagRelations < ActiveRecord::Migration[5.1]
  def change
    create_table :novel_tag_relations do |t|
      t.references :novel, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end

class AddKeywordToNovels < ActiveRecord::Migration[5.1]
  def change
    add_column :novels, :keyword_one, :string
    add_column :novels, :keyword_two, :string
    add_column :novels, :keyword_three, :string
    add_column :novels, :keyword_four, :string
    add_column :novels, :keyword_five, :string
  end
end

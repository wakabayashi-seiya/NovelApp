class AddImageToNovels < ActiveRecord::Migration[5.1]
  def change
    add_column :novels, :image, :string
  end
end

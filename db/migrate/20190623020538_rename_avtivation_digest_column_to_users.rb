class RenameAvtivationDigestColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :avtivation_digest, :activation_digest
  end
end
 
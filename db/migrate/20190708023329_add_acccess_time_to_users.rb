class AddAcccessTimeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :lastaccesstime, :datetime, default:DateTime.now
  end
end

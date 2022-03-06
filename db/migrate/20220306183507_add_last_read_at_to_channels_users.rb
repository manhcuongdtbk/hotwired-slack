class AddLastReadAtToChannelsUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :channels_users, :last_read_at, :datetime
  end
end

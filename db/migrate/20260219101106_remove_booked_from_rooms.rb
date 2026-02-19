class RemoveBookedFromRooms < ActiveRecord::Migration[8.1]
  def change
    remove_column :rooms, :booked, :boolean
  end
end

class CreateBookings < ActiveRecord::Migration[8.1]
  def change
    create_table :bookings do |t|
      t.date :booking_date, null: false
      t.time :start_time, null: false
      t.time :end_time, null: false
      t.references :user, null: true, foreign_key: true
      t.references :room, null: true, foreign_key: true

      t.timestamps
    end
  end
end

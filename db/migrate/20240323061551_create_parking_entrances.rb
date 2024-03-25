class CreateParkingEntrances < ActiveRecord::Migration[7.1]
  def change
    create_table :parking_entrances do |t|
      t.string :name

      t.timestamps
    end
  end
end

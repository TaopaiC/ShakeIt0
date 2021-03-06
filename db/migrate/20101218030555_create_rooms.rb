class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.integer :participant_counts
      t.boolean :is_finished, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :rooms
  end
end

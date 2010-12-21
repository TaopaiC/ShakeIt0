class CreateParticipants < ActiveRecord::Migration
  def self.up
    create_table :participants do |t|
      t.references :user
      t.references :room
      t.integer :score, :default => 0

      t.timestamps
    end

    add_index :participants, [:user_id, :room_id], :uniq => true
    add_index :participants, :room_id
  end

  def self.down
    drop_table :participants
  end
end

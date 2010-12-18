class CreateParticipants < ActiveRecord::Migration
  def self.up
    create_table :participants do |t|
      t.references :user
      t.references :room
      t.integer :score

      t.timestamps
    end

    add_index :participants, :user_id
    add_index :participants, :room_id
  end

  def self.down
    drop_table :participants
  end
end

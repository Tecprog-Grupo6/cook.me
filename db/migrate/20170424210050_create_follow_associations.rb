class CreateFollowAssociations < ActiveRecord::Migration[5.0]
  def change
    create_table :follow_associations do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index :follow_associations, :follower_id
    add_index :follow_associations, :followed_id
    add_index :follow_associations, [:follower_id, :followed_id], unique: true
  end
end

class AddAttachmentImageOneToRecipes < ActiveRecord::Migration
  def self.up
    change_table :recipes do |t|
      t.attachment :image_one
    end
  end

  def self.down
    remove_attachment :recipes, :image_one
  end
end

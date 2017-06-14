class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body
      t.references :recipe, foreign_key: true

      t.timestamps
    end
    add_index :comments, :recipe_id
  end
end

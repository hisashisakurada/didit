class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :menu
      t.integer :weight
      t.integer :counts
      t.integer :set
      t.string :comment
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

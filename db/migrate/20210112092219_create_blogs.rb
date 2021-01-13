class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.references :user, null: true, foreign_key: true
      t.text :title

      t.timestamps
    end
  end
end

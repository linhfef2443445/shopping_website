class CreateBlogs < ActiveRecord::Migration[5.1]
  def change
    create_table :blogs do |t|
      t.references :admin, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end

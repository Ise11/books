class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :author
      t.string :name
      t.text :description
      t.references :owner, index: true, foreign_key: true
      t.references :rent_by, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

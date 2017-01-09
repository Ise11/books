class AddGiveToBooks < ActiveRecord::Migration
  def change
    add_column :books, :give, :boolean
  end
end

class AddLocationToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :Location, :string
  end
end

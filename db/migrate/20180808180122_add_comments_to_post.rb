class AddCommentsToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :comments, :string
  end
end

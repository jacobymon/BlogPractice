class RemoveBlogFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :blog
  end
end

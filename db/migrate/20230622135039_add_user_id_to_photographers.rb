class AddUserIdToPhotographers < ActiveRecord::Migration[7.0]
  def change
    add_column :photographers, :user_id, :integer
    add_column :photographers, :description, :string
    end
end

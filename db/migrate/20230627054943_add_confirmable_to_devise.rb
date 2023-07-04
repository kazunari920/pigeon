# frozen_string_literal: true

class AddConfirmableToDevise < ActiveRecord::Migration[7.0]
  def change
    # usersテーブルに対する変更
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string # reconfirmable
    add_index :users, :confirmation_token, unique: true
    User.update_all confirmed_at: DateTime.now

    # photographersテーブルに対する変更
    add_column :photographers, :confirmation_token, :string
    add_column :photographers, :confirmed_at, :datetime
    add_column :photographers, :confirmation_sent_at, :datetime
    add_column :photographers, :unconfirmed_email, :string # reconfirmable
    add_index :photographers, :confirmation_token, unique: true
    Photographer.update_all confirmed_at: DateTime.now
  end
end

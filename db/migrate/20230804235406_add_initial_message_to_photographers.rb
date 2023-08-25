class AddInitialMessageToPhotographers < ActiveRecord::Migration[6.0]
  def change
    add_column :photographers, :initial_message, :string, default: 'ご依頼いただき、誠にありがとうございます。'
  end
end

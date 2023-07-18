class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :user, null: false, foreign_key: true
      t.references :photographer, null: false, foreign_key: true
      t.references :request, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end

class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :photographer, null: false, foreign_key: true
      t.string :name, null: false
      t.date :shooting_date
      t.string :shooting_location
      t.integer :budget
      t.text :comment
      t.string :address
      t.string :phone_number
      t.integer :status

      t.timestamps
    end
  end
end

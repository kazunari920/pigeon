class CreatePortfolios < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolios do |t|
      t.string :title
      t.text :description
      t.references :photographer, null: false, foreign_key: true

      t.timestamps
    end
  end
end

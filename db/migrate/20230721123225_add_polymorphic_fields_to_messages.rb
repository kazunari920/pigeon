class AddPolymorphicFieldsToMessages < ActiveRecord::Migration[7.0]
  def change
    add_reference :messages, :messageable, polymorphic: true, null: false
    add_reference :messages, :recipient, polymorphic: true, null: false
  end
end

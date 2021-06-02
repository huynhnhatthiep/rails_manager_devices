class CreateProviders < ActiveRecord::Migration[6.1]
  def change
    create_table :providers do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.string :delegate

      t.timestamps
    end
  end
end

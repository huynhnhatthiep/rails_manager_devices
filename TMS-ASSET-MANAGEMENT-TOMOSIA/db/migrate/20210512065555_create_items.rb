class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :status
      t.string :comment
      t.float :price
      t.text :detail
      t.references :category

      t.timestamps
    end
  end
end

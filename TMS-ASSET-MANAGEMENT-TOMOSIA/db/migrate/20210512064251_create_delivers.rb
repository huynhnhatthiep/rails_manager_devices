class CreateDelivers < ActiveRecord::Migration[6.1]
  def change
    create_table :delivers do |t|
      t.string :type_deliver
      t.integer :status
      t.datetime :start_date
      t.datetime :end_date
      t.text :reason
      t.text :note
      t.date :date_deliver
      t.references :request
      t.references :item

      t.timestamps
    end
  end
end

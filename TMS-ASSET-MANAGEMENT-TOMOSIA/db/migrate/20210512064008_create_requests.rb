class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.integer :type_request
      t.integer :status
      t.datetime :start_date
      t.datetime :end_date
      t.text :reason
      t.text :note
      t.references :item
      t.references :user

      t.timestamps
    end
  end
end

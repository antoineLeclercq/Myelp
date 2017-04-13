class CreateBusinesses < ActiveRecord::Migration[5.0]
  def change
    create_table :businesses do |t|
      t.string :name
      t.text :street
      t.string :city, :state, :zipcode, :area
      t.integer :phone
      t.timestamps
    end
  end
end

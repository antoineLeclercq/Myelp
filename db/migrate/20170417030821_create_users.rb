class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :full_name, :city, :state, :email, :password_digest
      t.timestamps
    end
  end
end

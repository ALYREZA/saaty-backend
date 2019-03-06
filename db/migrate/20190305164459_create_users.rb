class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :zone, limit: 50, default: "Tehran"
      t.integer :status, limit: 1, default: 0
      t.integer :is_admin, limit: 1,default: 0
      t.integer :plan, limit: 1, default: 0
      t.integer :projects_count, default: 0
      t.integer :clients_count, default: 0
      t.datetime :expired_at, default: nil

      t.timestamps

      t.index :email
    end
  end
end

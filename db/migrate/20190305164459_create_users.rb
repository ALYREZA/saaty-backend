class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.integer :status, limit: 1, default: 0
      t.boolean :isAdmin, default: false
      t.integer :plan, limit: 1, default: 0
      t.integer :projects_count, default: 0
      t.integer :clients_count, default: 0
      t.datetime :expired_at, null: true

      t.timestamps

      t.index :email
    end
  end
end

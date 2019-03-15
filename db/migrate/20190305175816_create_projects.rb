class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|

      t.decimal :cost, precision: 10, scale: 2, default: nil
      t.decimal :budget, precision: 15, scale: 2, default: nil

      t.integer :budget_type, limit: 1, default: nil
      t.integer :saats_count, default: 0

      t.integer :status, limit: 1, default: 0

      t.string :uuid, limit: 36
      t.string :name
      t.string :color, limit: 6, default: SecureRandom.hex(3)

      t.text :description, default: nil

      t.references :user, foreign_key: true
      t.references :client, foreign_key: true
      
      t.timestamps

      t.index :uuid
      t.index :name
    end
  end
end

class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :uuid
      t.integer :projects_count, default: 0
      t.references :user
      t.timestamps
    end
  end
end

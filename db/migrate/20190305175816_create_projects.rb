class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.references :client, foreign_key: true
      t.string :uuid
      t.string :color, limit: 6

      t.timestamps
    end
  end
end

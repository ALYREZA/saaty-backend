class CreateSaats < ActiveRecord::Migration[5.2]
  def change
    create_table :saats do |t|
      t.timestamp :value
      t.references :user, foreign_key: true
      t.references :client, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
      t.index :value
    end
  end
end

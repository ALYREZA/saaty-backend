class CreateSaats < ActiveRecord::Migration[5.2]
  def change
    create_table :saats do |t|
      t.string :uuid, limit: 36
      
      t.decimal :duration, precision: 10, scale: 2, default: nil
      
      t.references :user, foreign_key: true
      t.references :client, foreign_key: true
      t.references :project, foreign_key: true
      
      t.timestamp :start
      t.timestamp :end, default: nil
      
      t.timestamps
      
      t.index :uuid
      t.index :start
      t.index :end
      t.index :duration
    end
  end
end

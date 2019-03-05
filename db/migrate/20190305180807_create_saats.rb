class CreateSaats < ActiveRecord::Migration[5.2]
  def change
    create_table :saats do |t|
      t.dateTime :value
      t.references :user, foreign_key: true
      t.refrences :client
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end

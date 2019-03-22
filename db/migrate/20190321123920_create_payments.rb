class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.string :order_id, limit: 50
      t.integer :status, limit: 1,default: 1
      t.integer :track_id, default: nil
      t.string :payment_id, limit: 50
      t.integer :amount, default: nil
      t.string :card_no, limit: 16,default: nil
      t.timestamp :payment_date, default: nil
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :payments, :order_id
    add_index :payments, :status
    add_index :payments, :track_id
    add_index :payments, :payment_id
  end
end

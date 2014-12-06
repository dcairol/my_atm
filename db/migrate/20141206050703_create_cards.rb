class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.references :bank_account

      t.integer :pin
      t.string  :card_type
      t.integer :number
      t.date    :expiration_date

      t.timestamps
    end
  end
end

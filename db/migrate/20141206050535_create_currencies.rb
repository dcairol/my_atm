class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :currency
      t.float :exchange_rate
      t.string :symbol

      t.timestamps
    end
  end
end

class CreateBankAccounts < ActiveRecord::Migration
  def change
    create_table :bank_accounts do |t|
      t.references :user
      t.references :currency

      t.integer :number
      t.integer :balance

      t.timestamps
    end
  end
end

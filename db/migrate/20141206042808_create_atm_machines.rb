class CreateAtmMachines < ActiveRecord::Migration
  def change
    create_table :atm_machines do |t|

      t.timestamps
    end
  end
end

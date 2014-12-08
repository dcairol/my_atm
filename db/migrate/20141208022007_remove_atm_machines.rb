class RemoveAtmMachines < ActiveRecord::Migration
  def change
    drop_table :atm_machines
  end
end

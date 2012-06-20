class AddReferenceNumberToPatients < ActiveRecord::Migration
  def change
  	add_column :patients, :reference_number, :string
  	add_index :patients, [:physician_id, :reference_number], :unique => false
  	remove_column :visits, :reference_number
  end
end

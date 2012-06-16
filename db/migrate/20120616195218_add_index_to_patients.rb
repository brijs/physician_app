class AddIndexToPatients < ActiveRecord::Migration
  def change
  	add_index :patients, :first_name, :unique => false
  	add_index :patients, :last_name, :unique => false
  end
end

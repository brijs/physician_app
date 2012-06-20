class AddIndexRefNoToPatients < ActiveRecord::Migration
  def change
	add_index :patients, :reference_number, :unique => false
  end
end

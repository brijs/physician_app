class ChangeDataTypePhysicianIdInPatients < ActiveRecord::Migration
  def up
	  rename_column :patients, :physician_id, :physician_id_string
	  add_column :patients, :physician_id, :integer

	  Patient.reset_column_information
	  Patient.find_each { |c| c.update_attribute(:physician_id, c.physician_id_string) } 
	  remove_column :patients, :physician_id_string
  end

  def down
	  rename_column :patients, :physician_id, :physician_id_integer
	  add_column :patients, :physician_id, :string

	  Patient.reset_column_information
	  Patient.find_each { |c| c.update_attribute(:physician_id, c.physician_id_integer) } 
	  remove_column :patients, :physician_id_integer
  end
end

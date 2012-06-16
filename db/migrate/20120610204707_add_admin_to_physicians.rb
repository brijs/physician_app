class AddAdminToPhysicians < ActiveRecord::Migration
  def change
	  	add_column :physicians, :admin, :boolean, default: false
  end
end

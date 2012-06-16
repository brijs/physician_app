class AddIndexToPhysiciansEmail < ActiveRecord::Migration
	def change
	    add_index :physicians, :email, unique: true
  	end
end

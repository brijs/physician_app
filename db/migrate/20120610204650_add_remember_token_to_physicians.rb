class AddRememberTokenToPhysicians < ActiveRecord::Migration
  def change
  	    add_column :physicians, :remember_token, :string
	    add_index  :physicians, :remember_token
  end
end

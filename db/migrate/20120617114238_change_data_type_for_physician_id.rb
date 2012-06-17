class ChangeDataTypeForPhysicianId < ActiveRecord::Migration
  def up
  	change_column :patients, :physician_id, :integer
  end

  def down
	change_column :patients, :physician_id, :string
  end
end

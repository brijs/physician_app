class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.date :dob
      t.string :mobile
      t.string :sex
      t.string :physician_id

      t.timestamps
    end
  end
end

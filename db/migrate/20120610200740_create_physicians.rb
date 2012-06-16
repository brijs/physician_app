class CreatePhysicians < ActiveRecord::Migration
  def change
    create_table :physicians do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.date :dob
      t.string :mobile

      t.timestamps
    end
  end
end

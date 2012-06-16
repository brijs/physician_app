class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.string :reference_number
      t.date :date_of_visit
      t.text :complaints
      t.text :findings
      t.text :treatment
      t.text :notes

      t.timestamps
    end
  end
end

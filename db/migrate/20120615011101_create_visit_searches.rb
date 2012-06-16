class CreateVisitSearches < ActiveRecord::Migration
  def change
    create_table :visit_searches do |t|
      t.string :reference_number
      t.date :from_date
      t.date :to_date
      t.string :complaints
      t.string :findings
      t.string :treatment
      t.string :notes

      t.timestamps
    end
  end
end

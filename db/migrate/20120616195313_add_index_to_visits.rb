class AddIndexToVisits < ActiveRecord::Migration
  def change
 	add_index :visits, :date_of_visit, :unique => false
  	add_index :visits, :reference_number, :unique => false
 	add_index :visits, :complaints, :unique => false
  	add_index :visits, :findings, :unique => false
 	add_index :visits, :treatment, :unique => false
  	add_index :visits, :notes, :unique => false
 
 
   end
end

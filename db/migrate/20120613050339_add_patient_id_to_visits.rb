class AddPatientIdToVisits < ActiveRecord::Migration
  def change
  	add_column :visits, :patient_id, :integer
  end
end

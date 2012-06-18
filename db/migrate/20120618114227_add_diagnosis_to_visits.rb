class AddDiagnosisToVisits < ActiveRecord::Migration
  def change
  	add_column :visits, :diagnosis, :string
  end
end

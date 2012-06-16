class AddKeywordsToVisitSearch < ActiveRecord::Migration
  def change
  	add_column :visit_searches, :keywords, :string
  	remove_column :visit_searches, :complaints
  	remove_column :visit_searches, :findings
  	remove_column :visit_searches, :treatment
  	remove_column :visit_searches, :notes
  end
end

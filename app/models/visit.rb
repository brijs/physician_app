class Visit < ActiveRecord::Base
  attr_accessible :complaints, :date_of_visit, :findings, :diagnosis, :notes, :reference_number, :treatment

  belongs_to :patient

  validates :patient_id, presence: true
  validates :complaints, presence: true
  validates :date_of_visit, presence: true

  default_scope order: 'visits.created_at DESC'

  scope :for_physician,  
  	lambda { |physician| where("physicians.id = ?", physician)
  				.joins(:patient => :physician) }
  
end

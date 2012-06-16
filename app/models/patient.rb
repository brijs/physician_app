class Patient < ActiveRecord::Base
	attr_accessible :dob, :email, :first_name, :last_name, :mobile, :sex

	belongs_to :physician
	has_many :visits, dependent: :destroy

	validates :physician_id, presence: true
	
	validates :first_name, presence: true, length: { maximum: 50 }
	validates :last_name, presence: true, length: { maximum: 50 }
	validates :dob, presence: true
	validates_numericality_of :mobile, :only_integer => true,
		:message => "is not a valid phone number"
	validates :mobile,  :presence => true
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email,   presence:   true,
						format:     { with: VALID_EMAIL_REGEX },
						uniqueness: { case_sensitive: false }

	SEX_OPTIONS = %w(Male Female)
	validates :sex, :inclusion => {:in => SEX_OPTIONS}, presence: true



	default_scope order: 'patients.created_at DESC'

	# custom search 
	def self.search(search, physician_id, page = 1)
		paginate(per_page: 10,
				 page: page,
				 conditions: ['physician_id = ? AND (first_name LIKE ? OR last_name LIKE ?)', physician_id, "%#{search}%" ,"%#{search}%"])
	end


end

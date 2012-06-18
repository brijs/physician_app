class VisitSearch < ActiveRecord::Base
	attr_accessible  :keywords, :from_date, :reference_number, :to_date

	def visits (physician, page=1)
		 Visit.for_physician(physician)
				.paginate(per_page: 10,
						 page: page,
						 conditions: conditions);
	end

	private


	def keyword_conditions
		["(visits.complaints LIKE ? OR visits.findings LIKE ?
		 OR visits.treatment LIKE ? OR visits.notes LIKE ? 
		 OR visits.diagnosis LIKE ?)", 
		 "%#{keywords}%","%#{keywords}%","%#{keywords}%","%#{keywords}%",
		 "%#{keywords}%"] unless keywords.blank?
	end

	def from_date_conditions
		["visits.date_of_visit >= ?", from_date] unless from_date.blank?
	end

	def to_date_conditions
		["visits.date_of_visit <= ?", to_date] unless to_date.blank?
	end

	def reference_number_conditions
		["visits.reference_number = ?", reference_number] unless reference_number.blank?
	end

	def conditions
		[conditions_clauses.join(' AND '), *conditions_options]
	end

    #conditions_clauses: eg: "visits.reference_number = ?"
	def conditions_clauses
		conditions_parts.map { |condition| condition.first }
	end

	#conditions_options: eg: reference_number
	def conditions_options
		conditions_parts.map { |condition| condition[1..-1] }.flatten
	end

	# array of arrays(clause, option), returned by calling all xxx_condition methods
	def conditions_parts
		private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
	end
end

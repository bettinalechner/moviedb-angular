class Actor < ActiveRecord::Base
	has_many :roles
	has_many :movies, through: :roles

	def age
		Date.today.year - self.date_of_birth.year - ((Date.today.month > self.date_of_birth.month || (Date.today.month == self.date_of_birth.month && Date.today.day >= self.date_of_birth.day)) ? 0 : 1)
	end
end

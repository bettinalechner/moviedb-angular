class Actor < ActiveRecord::Base
	def age
		Date.today.year - self.date_of_birth.year - ((Date.today.month > self.date_of_birth.month || (Date.today.month == self.date_of_birth.month && Date.today.day >= self.date_of_birth.day)) ? 0 : 1)
	end
end

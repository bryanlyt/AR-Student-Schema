require_relative '../../db/config'

class Student < ActiveRecord::Base
# implement your Student model here
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/ }
    validates :email, uniqueness: true
    validates :age, numericality: { greater_than_or_equal_to: 5 }
    validate :valid_phone?

	def name
		"#{self.first_name} #{self.last_name}"
	end

	def age
		now = Date.today
		age = now.year - self.birthday.year - ((now.month > self.birthday.month || (now.month == self.birthday.month && now.day >= self.birthday.day)) ? 0 : 1)
	end

	def valid_phone?
        if self.phone.scan(/\d+/).count < 10
           errors.add(:phone, "must contain at least 10 digits, excluding non-numeric characters")
        end
    end

end
class BugPolicy < ApplicationPolicy
	
	def create?
		user.qa?
	end

	def new?
		user.qa?
	end

	def edit?
		user.developer? || user.manager?
	end

	def update?
		user.developer? || user.manager?
	end

	def index?
		user.manager? || user.developer? || user.qa?
	end
end
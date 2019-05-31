class ProjectPolicy < ApplicationPolicy
	
	def create?
		user.manager?
	end
	def new?
		user.manager?
	end
	def destroy?
	    user.manager?
	end

	def edit?
		user.manager?
	end

	def update?
		user.manager?
	end

	def index?
		user.manager? || user.developer? || user.qa?
	end


end

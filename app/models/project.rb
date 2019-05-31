class Project < ApplicationRecord
	has_many :projects_user
	has_many :users, through: :projects_user
	has_many :bugs, dependent: :destroy
end

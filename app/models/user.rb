class User < ApplicationRecord
	has_many :projects_user
	has_many :projects, through: :projects_user
	has_many :bugs
	enum user_type: [:manager,:developer,:qa]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

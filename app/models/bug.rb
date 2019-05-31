class Bug < ApplicationRecord
	belongs_to :project
	belongs_to :user
	mount_uploader :screenshot, ScreenshotUploader

	validates :bug_type,
		presence: true

	validates :title,
		presence: true,
		uniqueness: true

	validates :status,
		presence: true
end

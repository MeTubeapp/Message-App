class Message < ApplicationRecord
	has_one_attached :image
	belongs_to :user
	has_many :likes, dependent: :destroy


	def liked?(user)
		!!self.likes.find{|like| like.user_id == user.id}
	end
	
end

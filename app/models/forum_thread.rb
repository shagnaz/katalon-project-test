class ForumThread < ActiveRecord::Base
	belongs_to :user
	has_many :forum_posts

	validates :title, presence: true, length:{minimum: 50}
	validates :content, presence: true
end

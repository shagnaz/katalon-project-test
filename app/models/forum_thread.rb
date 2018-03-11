class ForumThread < ActiveRecord::Base
	extend FriendlyId

	friendly_id :title, use: :slugged
	belongs_to :user
	# tambah depent destroy ketika thread di hapus maka post ikut terhapus
	has_many :forum_posts, dependent: :destroy

	validates :title, presence: true, length:{maximum: 50}
	validates :content, presence: true



	def sticky
		sticky_order !=100
	end

	def pinit!
		self.sticky_order = 1
		self.save
	end

	scope :title_search, -> (title) {where("title like ?", title)}
    
end

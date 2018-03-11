class ForumThreadPolicy < ApplicationPolicy
	# apakah boleh edit
	def edit?
		# false #true berarti boleh, false tidak boleh

		# apakah user id sama dengan user yang memiliki record tsbt
		#record disini adalah thread
		user.id == record.user.id || user.admin?
		# jika benar maka akan mengembalikan true
		# ditambahkan admin setelah membuat enum
		
	end

	def update?
		user.id = record.user.id || user.admin?
	end

	def destroy?
		user.admin?
	end
end
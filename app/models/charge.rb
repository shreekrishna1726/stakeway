class Charge < ApplicationRecord
	belongs_to :user ,class_name:"Spree::User", foreign_key: :profile_id
	after_create :update_user_active



	private
		def update_user_active
			self.user.update(active:true);
		end

end




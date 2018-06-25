class Charge < ApplicationRecord
	belongs_to :user ,class_name:"Spree::User", foreign_key: :profile_id
	# after_create :update_user_active
	validates_presence_of :name
	validates_presence_of :phone
	validates_presence_of :payment_method
	validates_presence_of :amount
	validates_presence_of :txn_number


	private
		def update_user_active
			self.user.update(active:true);
		end

end




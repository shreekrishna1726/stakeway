module Spree
	User.class_eval do
		has_one :profile




		def update_and_create_store_credits
			store_credits.create(category_id: 1, created_by_id: 1, amount: 100.0, memo: '', currency: 'USD', currency: 1)
		end

		def has_orders?
			self.orders.all.collect(&:state).include?('complete')
		end

		def has_profile?
			profile.present?
		end



		def create_profile_after_first_order_complete
			@profile = build_profile(referral_id: Profile.all_needy_parent.first.uuid, active:true)
			p @profile
		end



	end
end
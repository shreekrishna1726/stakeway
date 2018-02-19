Spree::HomeController.class_eval do
	before_action :user_must_be_active!
	
	def index
	end

	def shop
	end

	def about_us
	end

	def contact_us	
	end

	def how_we_works
		@profile = Profile.first
	end

	def contact_us
		
	end

end
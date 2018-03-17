Spree::HomeController.class_eval do
	before_action :user_must_be_active!
	
	def index
		@searcher = build_searcher(params.merge(include_images: true))
      @products = @searcher.retrieve_products
      @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)
      @products.limit(5)
      p @products.count
      p"==========="
      @taxonomies = Spree::Taxonomy.includes(root: :children)
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


module Spree
	class UsersController < Spree::BaseController
    before_action :authenticate_user!



    def my_orders
      @my_orders = spree_current_user.orders
    end
  end
end
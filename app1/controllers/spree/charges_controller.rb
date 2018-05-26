module Spree
  class ChargesController < Spree::BaseController
    before_action :authenticate_user!
    before_action :set_api

    require 'Instamojo-rb'
    
    # @@api = Instamojo::API.new("e737b4ef3f19195217e591fc8ad3e057@instamojo.com", "0c12707dd9d2a2bda1a4fd7893e83a9e@instamojo.com")

    def new
      p @api
      p "-------------------------------------"
      if current_spree_user.profile
        redirect_to profile_path(current_spree_user.profile), notice: "You Are Already Register Our Channel:)"
      else
        payment_request = @api.client.payment_request({buyer_name:"XYZ",phone: "9971907800", amount:100, purpose: 'Registration Fee', send_email: true, email: current_spree_user.email, redirect_url: 'http://localhost:3000/charges/paymentDetail/'})
        redirect_to payment_request.longurl
      end
    end


    def paymentDetail
      @status = @api.client.payment_detail(params[:payment_id])
      p "-------------------------------"
      p @status 
      if @status.status == 'Credit'
        current_spree_user.update_attributes(active: true)
        if current_spree_user.profile.parent.present?
          current_spree_user.profile.update_parent_referral_amount(current_spree_user.profile)
        end
        redirect_to profile_path(current_spree_user.profile)
      else
        redirect_to '/'
      end
    end

    def read_more
      
    end

    private

    def set_api
      @api = Instamojo::API.new do |app|
        p app 
        p "--------------------"
        app.api_key = "e737b4ef3f19195217e591fc8ad3e057@instamojo.com"
        app.auth_token = "0c12707dd9d2a2bda1a4fd7893e83a9e@instamojo.com"
      end
    end


  end
end
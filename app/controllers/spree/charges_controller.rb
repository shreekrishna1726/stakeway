module Spree
  class ChargesController < Spree::BaseController
    # before_action :authenticate_user!
    # before_action :set_api

    # require 'Instamojo-rb'
    # require 'paypal-sdk-rest'
    # include PayPal::SDK::REST::DataTypes
    # include PayPal::SDK::Core::Logging
    # PayPal::SDK::REST.set_config(
    # :mode => "live", # "sandbox" or "live"
    # :client_id => "Aaewj1H855mxvvxqwD_0bHGGbPcLV4QfjRKCPgdameV929-Z7atuFTOv7bI1TeXx3OOszhFbApXBaDEx-UTcODg_kaTC0HnBQ0Zkm6kvQ1NZQwFYxWR2R_Bbis6VMy",
    # :client_secret => "EFBnNRCXZKobuKn9VEKpKdXAIGTWnoRlg6axJSGoiRvpWzNWLAAyq9c6gGig-dwQV52Rpj95PCixXbQb")
    
    # @@api = Instamojo::API.new("test_7a8227fcbc492750c81b5c7be5a", "test_0e624f8d7a4b979484533e38ded", "https://test.instamojo.com/api/1.1/")
    # @@api = Instamojo::API.new("test_7a8227fcbc492750c81b5c7be5a", "test_0e624f8d7a4b979484533e38ded", "https://test.instamojo.com/api/1.1/")
    def new
      @charge = Charge.where(profile_id: current_spree_user.id).first 
      if @charge.present?
        redirect_to '/account'
      else
      @charge = Charge.new
      end
      # if current_spree_user.active
      #   redirect_to '/profiles/new'
      # else
      #   @charge = Charge.new
      # end
      # @payment = Payment.new({
      #   :intent =>  "sale",
      #   :payer =>  {
      #     :payment_method =>  "paypal" },
      #   :redirect_urls => {
      #     :return_url => "http://localhost:3000/charges/paymentDetail",
      #     :cancel_url => "http://localhost:3000/" },
      #   :transactions =>  [{
      #     :amount =>  {
      #       :total =>  "150",
      #       :currency =>  "INR" },
      #     :description =>  "This is the payment transaction description." }]})
      
      # if @payment.create
      #   p"create"
      #   redirect_to @payment.links[1].href
      # else
      #   p"error"
      #   @payment.error 
      # end
    end


    def payu_callback
      notification = PayuIndia::Notification.new(request.query_string, options = {:key => 'hVo3I9mQ', :salt => 'd1zxVXdrOu', :params => params})
      P notification
        # payment = Payment.find(params[:paymentId])
        # if payment.execute( :payer_id => params[:PayerID] )
        #   current_spree_user.update_attributes(active: true)
        #   redirect_to '/profiles/new'          
        # else
        #   payment.error 
        # end
      # @status = @@api.client.payment_detail(params[:payment_id])
      # # p "-------------------------------"
      # p @status 
      # if @status.status == 'Credit'
      #   current_spree_user.update_attributes(active: true)
      #   if current_spree_user.profile.parent.present?
      #     current_spree_user.profile.update_parent_referral_amount(current_spree_user.profile)
      #   end
      #   redirect_to profile_path(current_spree_user.profile)
      # else
      #   redirect_to '/'
      # end
    end

    def read_more
      
    end


    def create
      @charge =  Charge.create(charge_param.merge(profile_id: current_spree_user.id))
      if @charge.save
        RestClient.get "http://api.msg91.com/api/sendhttp.php?sender=STKWAY&route=4&mobiles=+91 #{@charge.phone}&authkey=216365AN4qYNqoraNX5b02596d&country=91&message=Dear #{@charge.name}, Thank you for connecting us. Your premium account will be active next 24hr."
        redirect_to '/account', notice: 'Your details has been send to our channel. Once your verification will be completed, your premium account will active. Thanks:) '
      else
        render 'new', notice: @charge.errors.full_message.join('')
      end
    end

    private

    def set_api
      
      # api = Instamojo::API.new("e737b4ef3f19195217e591fc8ad3e057", "0c12707dd9d2a2bda1a4fd7893e83a9e", "https://instamojo.com/api/1.1/")
      # p api
      # @@api = Instamojo::API.new do |app|
      #   p app 
      #   p "--------------------"
      #   app.api_key = "e737b4ef3f19195217e591fc8ad3e057@instamojo.com"
      #   app.auth_token = "0c12707dd9d2a2bda1a4fd7893e83a9e@instamojo.com"
      # end
    end


    def charge_param
      params.require(:charge).permit(:amount, :txn_number, :name, :referralId, :phone, :payment_method)
    end


  end
end
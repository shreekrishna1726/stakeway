module Spree
	class ChargesController < Spree::BaseController
      

    def new
      if !params[:profile].blank?
        @profile = current_spree_user.profile
        p @profile
      else
        redirect_to '/'
      end
    end

    def create
      # Amount in cents
      @amount = 150

      customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'Rails Stripe customer',
        :currency    => 'usd'
      )
      if charge.save 
        charge_payment = current_spree_user.profile.build_charge(amount: charge["amount"], txn_number:charge["balance_transaction"]).save
        current_spree_user.profile.update_attributes(active: true)
        if current_spree_user.profile.parent.present?
          current_spree_user.profile.update_parent_referral_amount(current_spree_user.profile)
        end
        redirect_to '/' 
      end

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end
  end
end
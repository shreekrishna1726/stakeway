Spree::CheckoutController.class_eval do


  # Updates the order and advances to the next state (when possible.)
    def update
      if @order.update_from_params(params, permitted_checkout_attributes, request.headers.env)
        @order.temporary_address = !params[:save_user_address]
        unless @order.next
          flash[:error] = @order.errors.full_messages.join("\n")
          redirect_to(checkout_state_path(@order.state)) && return
        end

        if @order.completed?
          @current_order = nil
          flash.notice = Spree.t(:order_processed_successfully)
          flash['order_completed'] = true
          if current_spree_user.profile.active
            redirect_to completion_route
          else
            current_spree_user.profile.update_attributes(active: true)
            if current_spree_user.profile.parent.present?
              current_spree_user.profile.update_parent_referral_amount(current_spree_user.profile)
            end
            redirect_to completion_route
          end
        else
          redirect_to checkout_state_path(@order.state)
        end
      else
        render :edit
      end
    end
  

end
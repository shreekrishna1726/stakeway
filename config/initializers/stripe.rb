Rails.configuration.stripe = {
  :publishable_key => "pk_test_zLyCuT4IrRNdLIu8q62Xkpz2",
  :secret_key      => "sk_test_tMa59tgzOCfuroW4yGomOIIT"
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
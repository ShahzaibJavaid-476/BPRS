Rails.configuration.stripe = {
  publishable_key: ENV["pk_test_51QsHi9P9ga40zM9bXRbfCSPjVWA0mdew2PJ2jFj896XMhCZAEg6HW54yjVoRHeTzLLPITwWs4gcjx5uSrWIregDQ00TxcswZsZ"],
  secret_key: ENV["sk_test_51QsHi9P9ga40zM9bJsWrbdwo23aVwcizKgyRJBOkuucVpjyxOUFvtE99opM2ofhlizgj7S0VukdsZP3rscenKQBl00TbFfRwTe"]
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]

Rails.application.routes.draw do
  devise_for :users
  root to: 'customers#index'
  resources :plans
  resources :customers do
    resources :trainings
    resources :attendances
  end
  resources :subscriptions
  get 'subscriptions/:id/send_invoice_email', to: 'subscriptions#send_invoice_email', as: 'send_invoice_email'
  get 'subscriptions/:id/print_invoice', to: 'subscriptions#print_invoice', as: 'print_invoice'
  get 'customers/:customer_ids/send_birthday_email', to:'customers#send_birthday_email', as: 'send_birthday_email'
  get 'customers/:id/send_subscription_email', to:'customers#send_subscription_email', as: 'send_subscription_email'
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end

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

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end

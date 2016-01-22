Rails.application.routes.draw do
  get 'doctor/health_check', to: 'doctor/health_check#index'
end

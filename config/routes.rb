Rails.application.routes.draw do
  get 'doctor/status', to: 'doctor/health_check#index'
end

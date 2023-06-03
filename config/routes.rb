Rails.application.routes.draw do
	namespace 'api' do
		namespace 'v1' do
			resources :users
			resources :cards
      resources :bills
		end
	end
end
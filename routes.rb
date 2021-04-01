Rails.application.routes.draw do
	namespace :api, defaults: {format: 'json'} do

		namespace :v1 do
			scope :orders do
				get '/' => 'orders#index'
				get '/:id' => 'orders#show'
			  	delete '/:id' => 'orders#destroy'
			  	post '/' => 'orders#create'
			  	put '/:id' => 'orders#update'
			end
    	end
  	end
end

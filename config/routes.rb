Rails.application.routes.draw do
	devise_for :users

	root 'home#top'
	get 'home/about' => "home#about"

	resources :books
	resources :users, only: [:show, :index, :edit, :update, :destroy]

	resources :books, only: [:new, :create, :index, :show] do
		resource :favorites, only: [:create, :destroy]
		resources :book_comments, only: [:create, :destroy]
	end


end




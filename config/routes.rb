Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/:keyword/scrape', to: 'parse#scrape'
  get '/show', to: 'parse#show_posts'
  get '/sentflask', to: 'parse#sent_flask'
end

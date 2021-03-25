
Rails.application.routes.draw do

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users
    get 'user/profile'
    get 'problem/new'
    get 'problem/post'
    get 'user/problems'
    get 'problem/save'
    get 'problem/all'
    get 'problem/check_answer'
    get 'problem/search'
    get 'user/rating'
    delete 'problem/delete'
    post 'problem/edit'
    get 'problem/edit'
    root 'problem#all'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

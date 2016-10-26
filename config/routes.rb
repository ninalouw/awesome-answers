Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #this means when we receive a GET request with '/' url we invoke the index
  #action within the home controller
  # get "/" => 'home#index', as: :home

  get "/contact" => 'home#contact'
                                    # , as: :contact - rails generates a URL helper called contact_path
                                    # (and contact_url)
  post "/contact_submit" => 'home#contact_submit'

  root 'home#index'

  resources :users, only:[:create, :new]
  resources :sessions, only:[:new, :create] do
    delete :destroy, on: :collection 
  end

  # the url helpers (when we set it using `as`) is only concerned about the
  # URL and not the VERB. So even if we have two routes with the same url
  # and different verbs, the url helper should be the same.

  #can get all these routes using
  resources :questions, shallow: true do
  #when we define a route within the block for 'resources' we make the routes
  #assoc with the QuestionsController. We have different options we can use with these routes:
  # on: :collection => this makes the route not include an :id or :question_id
    # in it. This is very similar to the `index` action url
    #This is equivalent to :
    # get '/questions/search' => 'questions#search' ,as: :search_questions
    get :search, on: :collection
    # on: :member => this makes the route include an `:id` this is usually
   # useful for routes on actions that are related to a given record. This is
   # somewhat similar to the `edit` action.
   # get	'/questions/:id/flag' => 'questions#flag', as: :flag_question
    get :flag, on: :member

    # if you don't include any option (neither :collection nor :member) then
    # you're defining a nested resource which means it will include
    # `:question_id` in the url
    # POST	'/questions/:question_id/approve' => 'questions#approve', as: :question_approve
    post :approve
    # nesting the answers resources within the questions resources block
    # will make it so that every `answers` route is prefixed with:
    # `/questions/:question_id`. We will need the `question_id` to create
    # an answer associated with a question so we will stick with this way of
    # defining the routes. The routes helpers will also have `question_` prefix.
    resources :answers, only: [:create, :destroy] do
      resources :comments, only: [:create, :destroy]
    end
  end
  # get ({"/questions/new" => "questions#new", as: :new_question})
  # post ({'/questions' => 'questions#create', as: :questions})
  # get '/questions/:id' => 'questions#show', as: :question
  # get '/questions' => 'questions#index'
  # get '/questions/:id/edit' => 'questions#edit', as: :edit_question
  # patch '/questions/:id' => 'questions#update'
  # delete '/questions/:id' => 'questions#destroy'

end

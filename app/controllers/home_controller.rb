class HomeController < ApplicationController

  #this method is called 'actions'
  def index
    #this will render views/home/index.html.erb and it will use views/layouts/application.html.erb
    # render :index, layout: "application"
    #the line above is convention so we can do without it
    cookies[:last_visited] = Time.now
    cookies[:lucky_number] = rand(100)
  end



  def contact

  end

  def contact_submit
    @full_name = params[:full_name]
  end

end

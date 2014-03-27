class HomeController < ApplicationController
  def index
    # request['id']
    response.write "Hi from home controller"
  end
end
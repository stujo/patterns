class HomeController < ApplicationController
  around_action :layout
  before_action :header
  after_action :footer

  def index
    @message = "message from home contorller"
    render :index
  end

  def header
    response.write "<h1>My App</h1>"
  end

  def footer
    response.write "<p>&copy; me</p>"
  end

  def layout
    response.write "<html><body>"
    yield
    response.write "</body></html>"
  end
end
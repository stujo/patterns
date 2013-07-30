require "action_controller"
require "app/controllers/application_controller"
require "active_record"
require "app/models/user"
require "router"
require "config/routes"

# Autoloading:
#
#   class Object
#     def self.const_missing(name)
#       file_name = name.... # :User => "user"
#       require file_name
#       const_get name
#     end
#   end

class Application
  def call(env)
    request = Rack::Request.new(env)
    response = Rack::Response.new

    controller_name, action_name = route(request.path_info)

    controller_class = load_controller_class(controller_name) # HomeController
    controller = controller_class.new # HomeController.new
    controller.request = request
    controller.response = response
    controller.process action_name # controller.index

    response.finish
  end

  def route(path)
    Routes.route(path)
  end

  def load_controller_class(name)
    require "app/controllers/#{name}_controller"
    Object.const_get name.capitalize + "Controller" # "HomeController"
  end
end
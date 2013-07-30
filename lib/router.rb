class Router
  def initialize(&block)
    @routes = {}
    instance_eval(&block)
  end

  def match(routes) # { "/" => 'home#index', ...}
    routes.each_pair do |path, route|
      @routes[path] = route.split("#") # ['home', 'index']
    end
  end

  def route(path)
    @routes[path]
  end
end
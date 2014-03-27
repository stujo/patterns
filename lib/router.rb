class Router
  def initialize(&block)
    @routes = {
      # path => [controller, action]
    }
    instance_eval(&block)
  end

  def match(route)
    # route == {'/path' => 'home#index'}
    route.each_pair do |path, route|
      @routes[path] = route.split('#')
    end
  end

  def find(path)
    @routes[path]
  end
end
# Start with: shotgun -I. -Ilib
# Under Windows: rackup -I. -Ilib  (CTRL+C and restart on each change)

class Logger
  def initialize(app)
    @app = app
  end

  def call(env)
    puts "Requesting " + env["PATH_INFO"]
    @app.call(env)
  end
end

# use Logger

run -> env do
  method = env["REQUEST_METHOD"]
  path = env["PATH_INFO"]
  body = Routes[method][path].call
  [
    200,
    { 'Content-Type' => 'text/plain' },
    [body]
  ]
end

Routes = {
  "GET" => {
    # path => block
  }
}

def get(path, &block)
  Routes["GET"][path] = block
end

get "/" do
  "awesome!"
end

get "/hi" do
  "hello"
end
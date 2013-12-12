module ActionController
  class Base
    attr_accessor :request, :response

    def process(name)
      # name == "index"
      send name
    end
  end
end
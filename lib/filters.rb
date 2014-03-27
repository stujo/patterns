module Filters
  def self.included(base)
    base.extend ClassMethods # ActionController::Base
  end

  module ClassMethods
    def before_action(method)
      around_action do |controller, action|
        controller.send method
        action.call
      end
    end
    
    def after_action(method)
      around_action do |controller, action|
        action.call
        controller.send method
      end
    end
   
    # around_action :layout
    #
    # def layout
    #   yield
    # end
    #
    # around_action { |controller, action| action.call }
    def around_action(method = nil, &block)
      if block
        around_actions << block
      else
        around_actions << proc { |controller, action| controller.send method, &action }
      end
    end

    def around_actions
      @around_actions ||= []
    end
  end

  def process(action_name)
    # around_action :one
    # around_action :two

    # def one
    #   yield
    # end
    # def two
    #   yield
    # end
    #
    # action_proc = proc do
    #   one do
    #     two do
    #       super
    #     end
    #   end
    # end

    self.class.around_actions.reverse.inject(proc { super }) do |action_proc, block|
      proc { block.call(self, action_proc) }
    end.call
  end
end



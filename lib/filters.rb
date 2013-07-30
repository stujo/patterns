module Filters
  def self.included(base) # base = ActionController::Base
    base.extend ClassMethods
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
    
    def around_actions
      @around_actions ||= []
    end

    # around_action :layout
    #
    # def layout
    #   yield
    # end
    #
    #  or
    #
    # around_action do |controller, action|
    #   controller.response.write "..."
    #   action.call
    # end
    def around_action(method=nil, &block)
      if block
        around_actions << block
      else # method
        around_actions << proc { |controller, action| controller.send method, &action }
      end
    end
  end

  def process(action)
    # around_action :one
    # around_action :two
    #
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

    action_proc = proc { super }
    self.class.around_actions.reverse.each do |block|
      current_action = action_proc
      action_proc = proc { block.call(self, current_action) }
    end

    action_proc.call
  end
end
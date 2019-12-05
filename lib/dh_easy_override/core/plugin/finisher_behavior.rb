module DhEasy
  module Core
    module Plugin
      module FinisherBehavior
        def finish
          raise NotImplementedError.new('Must implement "finish" method.')
        end
      end
    end
  end
end

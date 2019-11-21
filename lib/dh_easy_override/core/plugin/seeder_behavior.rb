module DhEasy
  module Core
    module Plugin
      module SeederBehavior
        def seed
          raise NotImplementedError.new('Must implement "seed" method.')
        end
      end
    end
  end
end

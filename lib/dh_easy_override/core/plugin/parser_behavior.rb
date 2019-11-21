module DhEasy
  module Core
    module Plugin
      module ParserBehavior
        def parse
          raise NotImplementedError.new('Must implement "parse" method.')
        end
      end
    end
  end
end

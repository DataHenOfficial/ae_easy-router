module DhEasy
  module Router
    module Test
      module ParserBase
        attr_reader :mock_init_options

        def self.mock_data
          @@mock_data ||= Concurrent::Hash.new
          @@mock_data[Thread.current.object_id] ||= {}
        end

        def self.mock_clear_data
          mock_data.clear
        end

        def class_name
          self.class.name
        end

        def initialize opts = {}
          DhEasy::Router::Test::ParserBase.mock_data[class_name] ||= {}
          DhEasy::Router::Test::ParserBase.mock_data[class_name][:init_opts] = opts
        end

        def parse
          DhEasy::Router::Test::ParserBase.mock_data[class_name][:parse] = true
        end
      end

      class ParserA
        include DhEasy::Router::Test::ParserBase

        def class_name
          self.class.name
        end
      end

      class ParserB
        include DhEasy::Router::Test::ParserBase

        def class_name
          self.class.name
        end
      end
    end
  end
end

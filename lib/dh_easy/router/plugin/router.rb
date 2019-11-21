module DhEasy
  module Router
    module Plugin
      # Base router providing the basic functionalities from a router.
      module Router
        include DhEasy::Core::Plugin::InitializeHook

        # Local configuration (see DhEasy::Core::Config).
        attr_reader :local_config

        # Hook to initialize router configuration.
        #
        # @param [Hash] opts ({}) Configuration options.
        # @option opts [DhEasy::Config::Local,nil] :config (nil) Configuration to
        #   use.
        # @option opts [String] :config_file_path (nil) Configuration file to
        #   load when no +:config+ was provided (see
        #   DhEasy::Core::Config#file_path for default file).
        # @option opts [Boolean] :force (false) Will reload configuration file
        #   when `true`.
        #
        # @note `opts[:config]` will be prioritize over
        #   `opts[:config_file_path]` and `opts[:force]`.
        def initialize_hook_router_plugin_router opts = {}
          opts = {
            config: nil,
            config_file_path: nil,
            force: false
          }.merge opts
          @local_config = opts[:config]
          @local_config ||= DhEasy::Config::Local.new(
            file_path: opts[:config_file_path],
            force: opts[:force]
          )
        end

        # Initialize router and hooks.
        #
        # @param [Hash] opts ({}) Configuration options.
        #
        # @see #initialize_hook_router_plugin_router
        def initialize opts = {}
          initialize_hooks opts
        end

        # Router configuration.
        #
        # @return [Hash]
        def config
          local_config['router']
        end

        # Validates when a class name exists
        #
        # @param [String] name Class name to validate.
        #
        # @return [Boolean] `true` when exists, else `false`.
        def class_defined? name
          Object.const_defined? name
        end

        # Get a class from a class name.
        #
        # @param [String] name Class name to validate.
        #
        # @return [Class,nil] `nil` when class doesn't exists.
        def get_class name
          return nil unless class_defined? name
          Object.const_get name
        end
      end
    end
  end
end

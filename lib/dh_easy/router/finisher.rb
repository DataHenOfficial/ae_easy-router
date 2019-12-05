module DhEasy
  module Router
    # Finisher router designed to execute all finisher classes.
    class Finisher
      include DhEasy::Router::Plugin::Router

      # Execute the finisher class with options as described by router
      #   configuration and calling class's instance `finish` method.
      #
      # @param [Hash] opts ({}) Finisher initializer options (see
      #   DhEasy::Core::Plugin::Finisher).
      #
      # @raise [ArgumentError] `opts[:context]` is `nil`.
      # @raise [ArgumentError] `page_type` doesn't exists within routes.
      # @raise [NameError] A class with name equal to route's `class` attribute
      #   doesn't exists.
      #
      # @note Requires the route class to implement `finish` instance method.
      def route opts = {}
        context = opts[:context]
        if opts[:context].nil?
          raise ArgumentError.new('Must send a context to the finisher.')
        end

        class_name = nil
        config['finisher']['routes'].each do |item|
          # Validate class name
          executor_class = get_class item['class']
          if executor_class.nil?
            raise NameError.new("Class \"#{item['class']}\" doesn't exists, check your ae_easy config file.")
          end

          executor_class.new(opts).finish
        end
      end
    end
  end
end

module DhEasy
  module Router
    # Seeder router designed to execute all seeders classes.
    class Seeder
      include DhEasy::Router::Plugin::Router

      # Execute the seeder class with options as described by router
      #   configuration and calling class's instance `seed` method.
      #
      # @param [Hash] opts ({}) Seeder initializer options (see
      #   DhEasy::Core::Plugin::Seeder).
      #
      # @raise [ArgumentError] `opts[:context]` is `nil`.
      # @raise [ArgumentError] `page_type` doesn't exists within routes.
      # @raise [NameError] A class with name equal to route's `class` attribute
      #   doesn't exists.
      #
      # @note Requires the route class to implement `seed` instance method.
      def route opts = {}
        context = opts[:context]
        if opts[:context].nil?
          raise ArgumentError.new('Must send a context to the seeder.')
        end

        class_name = nil
        config['seeder']['routes'].each do |item|
          # Validate class name
          executor_class = get_class item['class']
          if executor_class.nil?
            raise NameError.new("Class \"#{item['class']}\" doesn't exists, check your dh_easy config file.")
          end

          executor_class.new(opts).seed
        end
      end
    end
  end
end

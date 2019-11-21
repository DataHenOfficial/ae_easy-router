module DhEasy
  module Router
    # Parser router designed to look over page_type for route to the right
    #   parser class.
    class Parser
      include DhEasy::Router::Plugin::Router

      # Execute the parser class with options as described by router
      #   configuration filtering by `page_type` and calling class's instance
      #   `parse` method.
      #
      # @param [Hash] opts ({}) Parser initializer options (see
      #   DhEasy::Core::Plugin::Parser).
      #
      # @raise [ArgumentError] `opts[:context]` is `nil`.
      # @raise [ArgumentError] `page_type` doesn't exists within routes.
      # @raise [NameError] A class with name equal to route's `class` attribute
      #   doesn't exists.
      #
      # @note Requires the route class to implement `parse` instance method.
      def route opts = {}
        context = opts[:context]
        if context.nil?
          raise ArgumentError.new('Must send a context to the parser.')
        end

        page_type = context.page['page_type'].strip.downcase
        class_name = nil
        config['parser']['routes'].each do |item|
          # Look for page type
          next if item['page_type'].strip.downcase != page_type

          # Validate class name
          executor_class = get_class item['class']
          if executor_class.nil?
            raise NameError.new("Class \"#{item['class']}\" doesn't exists, check your dh_easy config file.")
          end

          executor_class.new(opts).parse
          return
        end

        # Page type is not routed, raise an error.
        raise ArgumentError.new("Page type \"#{page_type}\" is not routed, check your dh_easy config file.")
      end
    end
  end
end

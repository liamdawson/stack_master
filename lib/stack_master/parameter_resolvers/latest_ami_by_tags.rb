module StackMaster
  module ParameterResolvers
    class LatestAmiByTags < Resolver
      array_resolver class_name: 'LatestAmisByTags'

      def initialize(config, stack_definition)
        @config = config
        @stack_definition = stack_definition
        @ami_finder = AmiFinder.new(@stack_definition.region)
      end

      def resolve(value)
        filters = @ami_finder.build_filters_from_string(value, prefix = "tag")
        latest_ami = @ami_finder.find_latest_ami(filters)
        latest_ami.nil? ? nil : latest_ami.image_id
      end
    end
  end
end

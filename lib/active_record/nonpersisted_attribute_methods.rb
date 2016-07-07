module ActiveRecord
  module NonPersistedAttributeMethods
    extend ActiveSupport::Concern

    included do
      cattr_accessor :nonpersisted_attribute_methods
      self.nonpersisted_attribute_methods = []
    end

    module ClassMethods
      def define_nonpersisted_attribute_methods(*attr_names)
        self.nonpersisted_attribute_methods.concat attr_names.flatten
        attr_names.flatten.each { |attr_name| define_attribute_method(attr_name) }
      end

      # Copied from gems/activemodel-3.2.11/lib/active_model/attribute_methods.rb
      # So that it won't end up calling define_method_attribute(attr_name) from ActiveRecord for
      # non-persisted attributes, which would cause it to run into this error:
      # NoMethodError: undefined method `type' for nil:NilClass
      # from active_record/attribute_methods/time_zone_conversion.rb:62:in `create_time_zone_conversion_attribute?'
      # since it didn't find a column in the table for this attribute.
      def define_attribute_method(attr_name)
        attribute_method_matchers.each do |matcher|
          method_name = matcher.method_name(attr_name)

          unless instance_method_already_implemented?(method_name)
            generate_method = "define_method_#{matcher.method_missing_target}"

            # Original:
            # if respond_to?(generate_method, true)
            if respond_to?(generate_method, true) and not nonpersisted_attribute_methods.include? attr_name
              send(generate_method, attr_name)
            else
              define_optimized_call generated_attribute_methods, method_name, matcher.method_missing_target, attr_name.to_s
            end
          end
        end
        attribute_method_matchers_cache.clear
      end
    end
  end
end
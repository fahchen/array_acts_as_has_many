require 'active_record'

require "array_acts_as_has_many/association_proxy"
require "array_acts_as_has_many/version"

module ArrayActsAsHasMany
  module ClassMethods
    def array_acts_as_has_many(name, options = {})
      one = name.to_s.singularize
      one_ids = "#{one}_ids"

      many = one.pluralize

      klass = one.classify.constantize

      class_eval do
        attr_accessor "#{many}_association_proxy"
      end

      define_method many do
        instance_variable_get("@#{many}_association_proxy") ||
          instance_variable_set("@#{many}_association_proxy", ArrayActsAsHasMany::AssociationProxy.new(self, klass, one_ids))
      end

      define_method "#{many}=" do |records|
        send(many).equal(records)
      end
    end
  end

  module InstanceMethods
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end

ActiveRecord::Base.send :include, ArrayActsAsHasMany


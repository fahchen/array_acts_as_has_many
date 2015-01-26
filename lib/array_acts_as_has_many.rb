require 'active_record'

require "array_acts_as_has_many/version"

module ArrayActsAsHasMany
  module ClassMethods
    def array_acts_as_has_many(name, options = {})
      one = name.to_s.singularize
      one_ids = "#{one}_ids"

      many = one.pluralize

      klass = one.classify.constantize

      define_method many do
        klass.where(id: send(one_ids))
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


require 'active_record'

require "array_acts_as_has_many/version"

module ArrayActsAsHasMany
  module ClassMethods
    def array_acts_as_has_many(name, options = {})

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


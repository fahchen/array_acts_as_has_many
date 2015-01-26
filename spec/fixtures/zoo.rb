class Zoo < ActiveRecord::Base
  array_acts_as_has_many :dogs
  array_acts_as_has_many :cats
end


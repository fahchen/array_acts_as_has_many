require 'spec_helper'

class Panda < ActiveRecord::Base; end
class Monkey < ActiveRecord::Base; end
class Zoo < ActiveRecord::Base
  array_acts_as_has_many :pandas
  array_acts_as_has_many :monkeys
end

describe ArrayActsAsHasMany do
  it 'returns true' do
    expect(true).to be_truthy
  end
end


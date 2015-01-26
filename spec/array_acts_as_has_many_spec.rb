require 'spec_helper'

describe ArrayActsAsHasMany do
  subject { Zoo.new }

  describe '#children' do
    let(:dogs) { [Dog.create, Dog.create, Dog.create] }

    it 'returns default empty' do
      expect(subject.dogs).to eq []
    end

    it 'returns children' do
      subject.dog_ids = dogs.map(&:id)

      expect(subject.dogs).to eq dogs
    end
  end
end


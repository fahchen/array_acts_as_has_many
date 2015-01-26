require 'spec_helper'

describe ArrayActsAsHasMany do
  subject { Zoo.create }

  describe '#children' do
    let(:dogs) { [Dog.create, Dog.create, Dog.create] }

    it 'returns default empty' do
      expect(subject.dogs).to eq []
    end

    it 'returns children' do
      subject.dog_ids = dogs.map(&:id)
      subject.save
      subject.reload

      expect(subject.dogs).to eq dogs
    end
  end

  describe '#children=' do
    let(:dogs) { [Dog.create, Dog.create, Dog.create] }

    it 'returns child_ids' do
      subject.dogs = dogs
      subject.reload

      expect(subject.dog_ids).to eq dogs.map(&:id)
    end
  end
end


require 'spec_helper'

describe ArrayActsAsHasMany do
  subject { Zoo.create }

  describe 'Responds to' do
    it { should respond_to(:dogs_association_proxy) }
  end

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

    it 'returns the same object_id' do
      expect(subject.dogs.object_id).to eq subject.dogs.object_id
    end

    it 'returns the different object_id' do
      expect(subject.dogs.object_id).not_to eq subject.dogs.reload.object_id
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

  describe '#children<<' do
    let(:dog) { Dog.create }

    it 'adds a child' do
      expect {
        subject.dogs << dog
      }.to change { subject.dog_ids.size }.by(1)
    end
  end
end


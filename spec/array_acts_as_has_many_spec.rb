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

  describe '#children.delete' do
    let(:dog) { Dog.create }
    before :each do
      subject.dogs << dog
    end

    it 'removes a child from the association' do
      expect {
        subject.dogs.delete dog
      }.to change { subject.dog_ids.size }.by(-1)
    end

    it 'not includes the child' do
      subject.dogs.delete dog
      expect(subject.dogs.include?(dog)).to be_falsy
    end

    it 'has the child in the database' do
      subject.dogs.delete dog
      expect(dog.persisted?).to be_truthy
    end
  end

  describe 'enumerable' do
    let(:dogs) { [Dog.create, Dog.create, Dog.create] }
    before :each do
      subject.dogs = dogs
      subject.reload
    end

    it 'returns the child_ids' do
      expect(subject.dogs.map(&:id)).to eq dogs.map(&:id)
    end
    it 'returns the odds' do
      expect(subject.dogs.collect { |dog| dog.id.odd? }).to eq dogs.collect { |dog| dog.id.odd? }
    end
  end

  describe '#reload' do
    let(:dogs) { [Dog.create, Dog.create, Dog.create] }
    before :each do
      subject.dogs
      subject.dog_ids = dogs.map(&:id)
      subject.save
    end

    it 'returns the child_ids' do
      subject.dogs.reload
      expect(subject.dogs).to eq dogs
    end
  end
end


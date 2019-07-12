require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(first_name: 'Andrzej', last_name: 'Testowy', email: 'andrzej@test.pl')}
  it { should have_one(:company) }
  it { should have_one(:address) }
  it { should accept_nested_attributes_for(:company) }
  it { should accept_nested_attributes_for(:address) }

  describe '.first_name'
    it {should validate_presence_of(:first_name)}
    it do
      should validate_length_of(:first_name).
      is_at_most(100).
      on(:create)
    end

  describe '.last_name'
    it {should validate_presence_of(:last_name)}
    it do
      should validate_length_of(:last_name).
      is_at_most(100).
      on(:create)
    end

  describe '.email'
    it 'when email format is incorrect' do
      subject.email = 'kopytko'

      expect(subject).to_not be_valid
    end

    it 'when email format is correct' do 
      subject.email = 'kopytko@email.org'

      expect(subject).to be_valid
    end

  describe '.birthdate'
    it "is optional" do
      expect(subject[:birthdate]).to be_nil
    end

    it 'cannot be in the future' do
      subject.birthdate = '2020-01-01'

      expect(subject).to_not be_valid
    end

    it 'have to be in past' do
      subject.birthdate = '1990-02-02'

      expect(subject).to be_valid
    end

  describe '.phone_number'
    it "is optional" do
      expect(subject[:phone_number]).to be_nil
    end

    it 'is compatible with country' do
      address = subject.build_address(country: 'PL', city: 'Warsaw', street: 'Marszalkowska', zip_code: '00-001')
      subject.save 

      expect(subject).to be_valid
    end

    it 'has wrong phone format' do
      address = subject.build_address(country: 'US', city: 'Warsaw', street: 'Marszalkowska', zip_code: '00-001')
      subject.save 

      expect(subject).to_not be_valid
    end 
end

require 'rails_helper'

RSpec.describe Company, type: :model do
    subject { described_class.new(name: 'Mantikora', user_id: '1')}
    it { should have_one(:address) }
    it { should accept_nested_attributes_for(:address) }
    it { should belong_to(:user)}

    describe '.name'
        it "is optional" do
            subject[:name] = nil
            expect(subject[:name]).to be_nil
        end

        it do
            should validate_length_of(:name).
            is_at_most(200).
            on(:create)
        end
end 
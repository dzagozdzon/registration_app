require 'rails_helper'

RSpec.describe Address, type: :model do
    subject {described_class.new(country: 'PL', city: 'Warsaw', street: 'Marszalkowska', zip_code: '00-001')}
    it { should belong_to(:addressable).optional}
    
    describe ".city, street, zipcode" do
        it 'have to be fullfilled in user fields' do
            expect(subject).to be_valid

            subject[:zip_code] = nil
            expect(subject).to_not be_valid
        end

        it 'are optionals in company fields' do
            user = User.new(first_name: 'Ala', last_name: 'Kot', email: 'alakot@mail.pl', phone_number: '500500500')
            user_address = user.build_address(country: 'PL', city: 'Warsaw', street: 'Marszalkowska', zip_code: '00-001')
            company = user.build_company(name: 'Nowa')
            company_address = user.company.build_address(country: 'PL', city: '', street: '', zip_code: '00-001')
            user.save 

            expect(company_address).to be_valid
        end
    end

    describe '.zip_code'
        it 'has to be correct with assigned country' do
            expect(subject).to be_valid

            subject[:zip_code] = '434349353'
            expect(subject).to_not be_valid
        end

    describe '.country'
        it 'must be assigned' do
            expect(subject).to be_valid

            subject[:country] = ''
            expect(subject).to_not be_valid
        end 
    
        it 'must be in ISO3166-1 alpha-2' do
            expect(subject).to be_valid

            subject[:country] = 'Poland'

            expect(subject).to_not be_valid
        end 
end
class Address < ApplicationRecord
    belongs_to :addressable, polymorphic: true, optional: true
    validates :country, presence: true, inclusion: { in: ISO3166::Country.all.map(&:alpha2) }
    validates :city, :street, :zip_code, presence: true, if: Proc.new{|factor| factor.addressable.is_a? User}
    validates :zip_code, zipcode: { country_code_attribute: :country }, if: Proc.new{|factor| factor.addressable ? Company : User }
end
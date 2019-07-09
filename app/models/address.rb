class Address < ApplicationRecord
    belongs_to :addressable, polymorphic: true, optional: true
    validates :country, presence: true
    validates :city, :street, :zip_code, presence: true, if: Proc.new{|factor| factor.addressable.is_a? User}
    validates :zip_code, #to_do if: Proc.new{|factor| factor.addressable.is_a? User || Company }
end
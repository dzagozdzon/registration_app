class Company < ApplicationRecord
    belongs_to :user
    has_one :address, as: :addressable
    accepts_nested_attributes_for :address

    validates :name, length: { maximum:200 }, if: Proc.new {|factor| factor.name.present? }
end
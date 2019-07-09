class Company < ApplicationRecord
    belongs_to :user
    has_one :address, as: :addressable
    accepts_nested_attributes_for :address

    validates :name, length: { maximum:100 }, unless: :name.blank?
end
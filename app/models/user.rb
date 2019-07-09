class User < ApplicationRecord
    has_one :company
    has_one :address, as: :addressable
    accepts_nested_attributes_for :address, :company

    validates :first_name, :last_name, presence: true, length: { maximum:100 }
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
    validates :phone_number #to_do
    validates :birthdate, date: { before: Proc.new { Date.today }, allow_blank: true }
end 
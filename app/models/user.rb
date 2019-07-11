class User < ApplicationRecord
  include CheckPhoneNumber
    has_one :company
    has_one :address, as: :addressable
    accepts_nested_attributes_for :address, :company

    validates :first_name, :last_name, presence: true, length: { maximum:100 }
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
    validate :birthdate_cannot_be_in_the_future
    validate :phone_format, if: Proc.new{|factor| factor.phone_number.present? }

    private

  
    def birthdate_cannot_be_in_the_future
      if birthdate.present? && birthdate > Date.today
        errors.add(:birthdate, "can't be in the future")
      end
    end    
end 
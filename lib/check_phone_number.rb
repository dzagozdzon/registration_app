module CheckPhoneNumber

    def phone_format
        if Phonelib.invalid_for_country? phone_number, address.country
            errors.add(:phone_number, "This is not valid format for choosen country")
        end
    end
end
    
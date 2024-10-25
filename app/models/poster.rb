class Poster < ApplicationRecord
# !validations/relationships/data_manipulation happen here
    def self.sort_by_creation(choice)
        # *ActiveRecord method order that sorts the created_at attribute
        order(created_at: choice.to_sym)
    end

    def self.i_like(choice)
        where("name ILIKE ?", "%#{choice}%")
    end
end
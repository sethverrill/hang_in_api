class Poster < ApplicationRecord
    # !validations/relationships/data_manipulation happen here
    def self.sort_by_creation(choice)
        # *ActiveRecord method order that sorts the created_at attribute
        order(created_at: choice.to_sym)
    end

    def self.i_like(choice)
        where("name ILIKE ?", "%#{choice}%")
    end

    def self.min_price(price)
        where("price >= ?", price)
    end    

    def self.max_price(price)
        where("price <= ?", price)
    end
end
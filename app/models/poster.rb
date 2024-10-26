class Poster < ApplicationRecord
    def self.sort_by_creation(choice)
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
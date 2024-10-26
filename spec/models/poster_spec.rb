require 'rails_helper'

RSpec.describe Poster, type: :model do 
  before do
    @poster1 = Poster.create(name: "LAZINESS",
      description: "You can't change anything.",
      price: 25.00,
      year: 2022,
      vintage: false,
      img_url: "./assets/laziness.jpg",
      )
    @poster2 = Poster.create(name: "PROCRASTINATION",
      description: "Better to avoid failure by not trying at all.",
      price: 48.00,
      year: 2017,
      vintage: true,
      img_url: "./assets/procrastination.jpg",
      )
    @poster3 = Poster.create(name: "DESPAIR",
      description: "Let someone else do it; you’ll just mess it up.",
      price: 73.00,
      year: 2015,
      vintage: false,
      img_url: "./assets/despair.jpg",
      )    
  end

  describe ".sort_by_creation" do
    it "sorts posters in ascending order by creation date" do
      posters = Poster.sort_by_creation('asc')
      expect(posters).to eq([@poster1, @poster2, @poster3])
    end

    it "sorts posters in descending order by creation date" do
      posters = Poster.sort_by_creation('desc')
      expect(posters).to eq([@poster3, @poster2, @poster1])
    end
  end

  describe ".i_like" do
    it "returnes poster with name that match the query" do
      posters = Poster.i_like("des")
      expect(posters).to include(@poster3)
    end
  end

  describe ".min_price" do
    it "returns posters with price greater than or equal to specified amount" do
      posters = Poster.min_price(50)
      expect(posters).to include(@poster3)
    end
  end

  describe ".max_price" do
    it "returns posters with price less than or equal to specified amount" do
      posters = Poster.max_price(50)
      expect(posters).to include(@poster1, @poster2)
    end
  end
end
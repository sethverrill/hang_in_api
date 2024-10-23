require 'rails_helper'

RSpec.describe "Fetch all posters" do 
  before(:each) do
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
    it 'can fetch all posters' do
       get '/api/v1/posters' #First we get our route, what are we expecting next?
       expect(response).to be_successful 
       expect(response.status).to eq(200)
        
       posters = JSON.parse(response.body,symbolize_names:true)[:data]
       #now we have to check if our data attributes are correct
       expect(posters).to be_an(Array)
       
       poster = posters[0]

       expect(poster[:id]).to be_an(Integer)
       expect(poster[:type]).to eq('poster')

       attrs  = poster[:attributes]
       
       expect(attrs[:name]).to be_an(String)
       expect(attrs[:description]).to be_an(String)
       expect(attrs[:price]).to be_an(Float)
       expect(attrs[:year]).to be_an(Integer)
       expect(attrs[:vintage]).to be(true).or be(false)
       expect(attrs[:img_url]).to be_an(String)
    end
    
    it 'can fetch individual posters' do
      get "/api/v1/posters/#{@poster1.id}"
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      puts response.body
      poster = JSON.parse(response.body,symbolize_names:true)
      
      expect(poster[:id].to_i).to eq(@poster1.id)
      expect(poster[:name]).to eq(@poster1.name)
      expect(poster[:description]).to eq(@poster1.description)
      expect(poster[:price]).to eq(@poster1.price)
      expect(poster[:year]).to eq(@poster1.year)
      expect(poster[:vintage]).to eq(@poster1.vintage)
      expect(poster[:img_url]).to eq(@poster1.img_url)
    end
  
end 
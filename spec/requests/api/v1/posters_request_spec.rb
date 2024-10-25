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
      #*now we have to check if our data attributes are correct
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
      
      poster = JSON.parse(response.body,symbolize_names:true)[:data]
      
      expect(poster[:id].to_i).to eq(@poster1.id)
      expect(poster[:type]).to eq('poster')

      attrs = poster[:attributes]

      expect(attrs[:name]).to eq(@poster1.name)
      expect(attrs[:description]).to eq(@poster1.description)
      expect(attrs[:price]).to eq(@poster1.price)
      expect(attrs[:year]).to eq(@poster1.year)
      expect(attrs[:vintage]).to eq(@poster1.vintage)
      expect(attrs[:img_url]).to eq(@poster1.img_url)
     end

  it 'can update poster data' do 
      patch "/api/v1/posters/#{@poster1.id}", params: {
         poster:{
           name: 'book',
           description: 'what should i name my dog' 
          }
        }    
      
    expect(response).to be_successful
    expect(response.status).to eq(200)

    get "/api/v1/posters/#{@poster1.id}"
    updated_poster = JSON.parse(response.body,symbolize_names:true)[:data]

    expect(response).to be_successful               
    expect(updated_poster).to have_key(:attributes)

    attrs = updated_poster[:attributes]

    expect(attrs).to have_key(:name)
    expect(attrs[:name]).to eq("book")
  end
  
  it 'can fetch all posters and provide a meta count' do
    get '/api/v1/posters'

    expect(response).to be_successful
    expect(response.status).to eq(200)

    meta = JSON.parse(response.body, symbolize_names: true)[:meta]
    poster_count = Poster.count
    expect(meta[:count]).to eq(poster_count)
  end
  
  it 'can create a posters' do
    poster_info = {
        "name": "DEFEAT",
        "description": "It's too late to start now.",
        "price": 35.00,
        "year": 2023,
        "vintage": false,
        "img_url":  "https://unsplash.com/photos/brown-brick-building-with-red-car-parked-on-the-side-mMV6Y0ExyIk"
    }

    post '/api/v1/posters', params: { poster: poster_info} #First we get our route, what are we expecting next?
    expect(response).to be_successful 
    expect(response.status).to eq(200)
      
    poster = JSON.parse(response.body,symbolize_names:true)[:data]
    #now we have to check if our data attributes are correct        

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
  
  it ' can destroy an image' do
    posters = Poster.all
    expect(posters.count).to eq(3)
    
    delete "/api/v1/posters/#{@poster2.id}"

    expect(response).to be_successful 
    expect(response.status).to eq(204)

    expect(posters.count).to eq(2)
  end

  it 'can sort posters by created_at_date asc' do
  # !Looking to sort based on created_at_date asc & desc
    get '/api/v1/posters', params: {sort: 'asc'}
    
    expect(response).to be_successful 
    expect(response.status).to eq(200)
          
    posters = JSON.parse(response.body,symbolize_names:true)[:data]
    expect(posters).to be_an(Array)

    poster = posters[0]
    expect(poster[:id]).to be_an(Integer)
    expect(poster[:type]).to eq('poster')
    expect(poster[:id]).to eq(@poster1.id)
  end
    
  it 'can sort posters by created_at_date desc' do
    # !Looking to sort based on created_at_date asc & desc
    get '/api/v1/posters', params: {sort: 'desc'}
    
    expect(response).to be_successful 
    expect(response.status).to eq(200)
          
    posters = JSON.parse(response.body,symbolize_names:true)[:data]
    expect(posters).to be_an(Array)

    poster = posters[0]
    expect(poster[:id]).to be_an(Integer)
    expect(poster[:type]).to eq('poster')
    expect(poster[:id]).to eq(@poster3.id)
  end
end     

require "sinatra"
require "sinatra/reloader"
require "http"
require "json"
require "sinatra/cookies"

get("/") do
  redirect("/dogs")
end

get("/dogs") do
  erb(:dogs)
end

get("/dog_image") do
  @user_dog = params.fetch("dog")
  dogs_url = "https://dog.ceo/api/breed/#{@user_dog}/images/random"
  @raw_response = HTTP.get(dogs_url).to_s

  @parsed_dog_data = JSON.parse(@raw_response)
  @dog_hash = @parsed_dog_data.dig("message")
  erb(:dog_result)
end

get("/random_dog") do 
  random_dog_url = "https://dog.ceo/api/breeds/image/random"
  @get_random_dog = HTTP.get(random_dog_url).to_s
  @parsed_random_data = JSON.parse(@get_random_dog)
  @random_dog_hash = @parsed_random_data.fetch("message")
  erb(:random)
end

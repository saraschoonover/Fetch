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

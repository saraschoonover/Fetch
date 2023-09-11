require "sinatra"
require "sinatra/reloader"
require "http"
require "json"
require "sinatra/cookies"
require 'sinatra/bootstrap'

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

get("/dog_facts") do 
  dog_facts_url = "https://dogapi.dog/api/v2/facts?limit=1"
  @get_dog_facts = HTTP.get(dog_facts_url).to_s
  @parsed_dog_facts = JSON.parse(@get_dog_facts)
  @facts_hash = @parsed_dog_facts.fetch("data")[0].fetch("attributes").fetch("body")
  erb(:dog_facts)
end

get("/cat_facts") do 
  cat_facts_url = "https://meowfacts.herokuapp.com/?count=1"
  @get_cat_facts = HTTP.get(cat_facts_url).to_s
  @parsed_cat_facts = JSON.parse(@get_cat_facts)
  @cat_facts_hash = @parsed_cat_facts.fetch("data")[0]
  erb(:cat_facts)
end

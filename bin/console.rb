#created a bin/console.rb to test the API 
require 'pry'
require 'rest-client'
require 'json'

# response = RestClient.get("https://api.jikan.moe/v3/season/2020/spring")
# data = JSON.parse(response)

response = RestClient.get("https://api.jikan.moe/v3/season/2020/spring")
anime_data = JSON.parse(response)

#anime_data["anime"][0]["producers"][0]["name"]
anime_data_f = anime_data["anime"].reject do |anime|
    anime["producers"][0] == nil
end

a = anime_data["anime"].map do |anime|
    anime["producers"][0]
end

b = a.reject do |p|
    p == nil
end

producer_name_array = b.map do |p|
    p["name"]
end.uniq



binding.pry

"hoho"
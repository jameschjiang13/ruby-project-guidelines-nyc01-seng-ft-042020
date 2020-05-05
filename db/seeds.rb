Producer.delete_all
Anime.delete_all
List.delete_all
AnimeList.delete_all

response = RestClient.get("https://api.jikan.moe/v3/season/2020/spring")
anime_data = JSON.parse(response)

a = anime_data["anime"].map do |anime|
    anime["producers"][0]
end

b = a.reject do |p|
    p == nil
end

producer_name_array = b.map do |p|
    p["name"]
end.uniq

producer_name_array.each do |producer_name|
    Producer.create(name: producer_name)
end



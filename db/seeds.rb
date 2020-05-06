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

anime_data_f = anime_data["anime"].reject do |anime|
    #this gives all the animes that have producers
    anime["producers"][0] == nil
end

anime_data_f.each do |anime|
    #creates all rows and have title, synopsis, rating filled
    Anime.create(title: anime["title"], synopsis: anime["synopsis"], rating: anime["score"])
end

anime_data["anime"].each do |anime|
    Anime.all.each do |a_instance|
        if a_instance.title == anime["title"]
            Producer.all.each do |p_instance|
                if p_instance.name == anime["producers"][0]["name"]
                    p_instance.animes << a_instance
                end
            end
        end
    end
end

List.create(name: "My Watch List")

binding.pry
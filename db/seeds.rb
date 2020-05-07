Producer.delete_all
Anime.delete_all
List.delete_all
AnimeList.delete_all

response_1 = RestClient.get("https://api.jikan.moe/v3/season/2020/spring")
anime_data_1 = JSON.parse(response_1)

response_2 = RestClient.get("https://api.jikan.moe/v3/season/2019/winter")
anime_data_2 = JSON.parse(response_2)

response_3 = RestClient.get("https://api.jikan.moe/v3/season/2019/fall")
anime_data_3 = JSON.parse(response_3)

response_4 = RestClient.get("https://api.jikan.moe/v3/season/2019/summer")
anime_data_4 = JSON.parse(response_4)

anime_data_array = anime_data_1["anime"] + anime_data_2["anime"] + anime_data_3["anime"] + anime_data_4["anime"]

a = anime_data_array.map do |anime|
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

anime_data_f = anime_data_array.reject do |anime|
    #this gives all the animes that have producers
    anime["producers"][0] == nil
end

anime_data_f.each do |anime|
    #creates all rows and have title, synopsis, rating filled
    Anime.create(title: anime["title"], synopsis: anime["synopsis"], rating: anime["score"])
end

anime_data_array.each do |anime|
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

List.create(name: "My Collection")

List.create(name: "Disliked")
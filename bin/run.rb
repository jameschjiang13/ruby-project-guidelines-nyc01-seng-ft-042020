require_relative '../config/environment'
require 'pry'
require "tty-prompt"
prompt = TTY::Prompt.new

puts "Welcome, here is a top rated anime in 2020"
round_counter = 0
current_anime = sorted_anime[0]
while List.first.animes.count < 5 do
    # current_anime = sorted_anime[round_counter]
    puts "Tile: #{current_anime.title}, Rating: #{current_anime.rating}, Synopsis: #{current_anime.synopsis}"
    choice = prompt.select("Choose an option", "Haven't seen it, add to the list", "Have seen it, I like it, find me something similar", "Not a fan, find me something different") 
    if choice == "Haven't seen it, add to the list"
       AnimeList.create(anime_id: current_anime.id, list_id: 1)
        List.first.animes << current_anime
       puts "we have added this anime to your watch list! Here is another anime"
       round_counter += 1
       current_anime = sorted_anime[round_counter]
    end
    if choice == "Have seen it, I like it, find me something similar"
        current_producer = current_anime.producer
        filtered_anime_data = current_producer.animes.reject do |anime|
            anime == current_anime
        end
        round_counter += 1
        if filtered_anime_data == []
            #just in case there is no more animes from this producer
            current_anime = sorted_anime[round_counter]
        else
            current_anime = filtered_anime_data.first
        end
        
        puts "here, see another one"
        #how to loop up change the current_anime
    end
    if choice == "Not a fan, find me something different"
        puts "Good thing we have hundreds of other animes, here is another one!"
        round_counter += 1
       current_anime = sorted_anime[round_counter]
    end
end

 anime_title_array = List.first.animes.map do |anime|
    anime.title
 end

 puts anime_title_array

require_relative '../config/environment'
require 'pry'
require "tty-prompt"
prompt = TTY::Prompt.new 

#WELCOME MESSAGE
puts ""
puts "Welcome to My Anime Lists!"
puts ""
puts "*******************************"
puts ""
sleep(2)
puts "A place to find new Anime and organize your favorites."
puts ""
    sleep(2)
puts "Lets get started!"
    sleep(2)
puts ""

# #FIRST MENU:
# 1. find a new anime 
# 2. edit my lists 
# 3. end

first_menu = prompt.select("Menu:", "Find a New Anime", "View/Edit My Lists", "Exit")

    if first_menu == "Find a New Anime"
        round_counter = 0
        current_anime = sorted_anime[0]
        status = 1
        
            while status == 1 do
                puts ""
                puts "Tile: #{current_anime.title}\nRating: #{current_anime.rating}\nSynopsis: #{current_anime.synopsis}"
                puts ""
            #options of what to do with the Anime displayed above.
            # 1. havent seen it add it to my watch list 
                ### the interpolated List.first.name in this option reflects if the 
                # user wants to change the name of the list
            # 2. have seen it, i like it, find me something similar
            # 3. not a fan find me something different 
            # 4. ADDED Done, Show me my lists
                choice = prompt.select("Choose an option", "Haven't seen it! Add to #{List.first.name}", "Have seen it, I like it, find me something similar", "Not a fan, find me something different", "Done! Show me My Lists") 
                if choice == "Haven't seen it! Add to #{List.first.name}"
                    AnimeList.create(anime_id: current_anime.id, list_id: 1)
                        List.first.animes << current_anime
                    puts ""
                    puts "DONE! We've added #{current_anime.title} to your list!\n\nHere is another Anime"
                    round_counter += 1
                    current_anime = sorted_anime[round_counter]
                end
                if choice == "Have seen it, I like it, find me something similar"
                    
                    #EDITS BY CAROLINE
                    puts ""
                    yes_or_no = prompt.yes?("Would you like to add this to #{List.second.name} ?")
                    if yes_or_no
                        List.second.animes << current_anime
                        puts ""
                        puts "Awesome! We've added #{current_anime.title} to your collection."
                    end 
                    #END OF EDITS

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
                    sleep (2)
                    puts ""
                    puts "Here is a similar Anime!"
                    #how to loop up change the current_anime
                end
                if choice == "Not a fan, find me something different"
                    puts ""
                    puts "Good thing we've got hundreds of other Anime, here is another!"
                    round_counter += 1
                    current_anime = sorted_anime[round_counter]
                end
                if choice == "Done! Show me My Lists"
                    puts ""
                    puts "Here are your final lists. Happy watching!"
                    puts ""
                    sleep(2)
                    puts "#{List.first.name}:"
                    puts ""
                    anime_title_array = 
                    List.first.animes.map do |anime|       
                        anime.title
                    end
                    puts anime_title_array
                    puts ""
                    puts "#{List.second.name}:"
                    puts ""
                    
                    anime_title_array_2 = 
                    List.second.animes.map do |anime|       
                        anime.title
                    end

                    puts anime_title_array_2
                    puts ""

                    status = 2
                    # how can we get this back to first menu instead of exiting app
                end 
            end
        
    end

    ### EDITS BY CAROLINE 
    if first_menu == "View/Edit My Lists"
        inside_view_edit = prompt.select("Would you like to:", "View your lists", "Remove an Anime", "Update list name")
        if inside_view_edit == "View your lists"
                #displays a menu to choose list 1 or list 2
            puts ""
            #uses List.first.name etc. to account for the fact that they may change the list name
            list_prompt = prompt.select("Choose the list you would like to view:", List.first.name, List.second.name)
            if list_prompt == List.first.name
                #code to display the animes on list 1
                anime_list_titles_1 = List.first.animes.map do |anime|
                    "\n #{anime.title}" 
                end 
                puts ""
                puts "#{List.first.name}:"
                puts anime_list_titles_1
                puts "" 
            end
            if list_prompt == List.second.name
                #code to display the animes on list 2 
                anime_list_titles_2 = List.second.animes.map do |anime|
                    "\n #{anime.title}"
                end 
                puts ""
                puts "#{List.second.name}:"
                puts anime_list_titles_2
                puts ""
            end 
        end 

        if inside_view_edit == "Remove an Anime"
            list = List.first.animes
            #prompt which list would you like to remove from 
            remove_from_list = prompt.select("Which list would you like to remove from?", List.first.name, List.second.name)
            if remove_from_list == List.first.name
                #code to display the animes on list 1
                anime_list_titles_1 = List.first.animes.map do |anime|
                    "\n #{anime.title}" 
                end 
                puts ""
                puts "#{List.first.name}:"
                puts anime_list_titles_1
                puts ""
            end
            if remove_from_list == List.second.name
                #code to display the animes on list 2 
                anime_list_titles_2 = List.second.animes.map do |anime|
                    "\n #{anime.title}"
                end 
                puts ""
                puts "#{List.second.name}:"
                puts anime_list_titles_2
                puts ""
                list = List.second.animes
            end 

            #NEEDS A LOOP ? we need to be able for them to not enter the right name a few times

            puts "Please type the name of the Anime you would like to remove:"
            puts ""
            title_to_remove = gets.chomp.strip
            #iterates over the list that the user has chosen to match the title with the input 
            #and then to destroy the instance from the list
            if list.exists?(title: title_to_remove)
                list.each do |anime|
                    if anime.title == title_to_remove
                        list.delete(anime)
                        puts ""
                        puts "We have removed #{title_to_remove} from your list."
                        puts ""
                    end 
                end
            else 
                    puts ""
                    puts "Sorry, we cannot find that Anime in the list."
                    puts ""
            end

            #lets get this able to go back to the main menu!  
        end

        #thursday morning edits
        if inside_view_edit == "Update list name"
            list_choice = List.first
            edit_name = prompt.select("Which list name would you like to change?", List.first.name, List.second.name)
            if edit_name == List.first.name
                #code to display the animes on list 1
                anime_list_titles_1 = List.first.animes.map do |anime|
                    "\n #{anime.title}" 
                end 
                puts ""
                puts "#{List.first.name}:"
                puts anime_list_titles_1
                puts ""
            end
            if edit_name == List.second.name
                #code to display the animes on list 2 
                anime_list_titles_2 = List.second.animes.map do |anime|
                    "\n #{anime.title}"
                end 
                puts ""
                puts "#{List.second.name}:"
                puts anime_list_titles_2
                puts ""
                list_choice = List.second
            end 
            
            puts "Please type the new name of your list:"
            puts ""
            name_change = gets.chomp.strip
            #assigning the list chosen name = name that they have typed 
            list_choice.update(name: name_change)
            puts ""
            puts "Great! We have changed the name of your list to: #{name_change}"
            puts ""
        end  
    end
    ##END OF EDITS 

    if first_menu == "Exit"
        puts ""
        puts "Thank you for using My Anime Lists. NOW GO WATCH SOME ANIME!"
        puts ""
    end
    








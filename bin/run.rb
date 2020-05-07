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
sleep(1)
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
menu_loop = "go"
while menu_loop == "go"
    first_menu = prompt.select("Menu:", "Browse Top Anime", "Search by Title", "View/Edit My Lists", "Exit")

        if first_menu == "Browse Top Anime"
            status = 1
                while status == 1 do
                    current_anime = (sorted_anime - List.first.animes - List.second.animes - List.third.animes)[0]
                    puts ""
                    puts "Tile: #{current_anime.title}\nRating: #{current_anime.rating}\nSynopsis: #{current_anime.synopsis}"
                    puts ""
                    choice = prompt.select("Choose an option", "Add to a list", "Keep browsing", "Done! Show me My Lists") 
                    if choice == "Add to a list"
                        multiple_choices = [List.first.name, List.second.name]
                        multiple_return = prompt.multi_select("Which list(s) would you like to add to", multiple_choices)
                        #prompt multiple 
                        if multiple_return == [List.first.name]
                            List.first.animes << current_anime
                            puts ""
                            puts "DONE! We've added #{current_anime.title} to #{List.first.name}!\n\nHere is another Anime"
                        end

                        if multiple_return == [List.second.name]
                            List.second.animes << current_anime
                            puts ""
                            puts "DONE! We've added #{current_anime.title} to #{List.second.name}!\n\nHere is another Anime"
                        end

                        if multiple_return == [List.first.name, List.second.name]
                            List.first.animes << current_anime
                            List.first.animes << current_anime
                            puts ""
                            puts "DONE! We've added #{current_anime.title} to both lists!\n\nHere is another Anime"
                        end
                    end
                    # if choice == "Add to #{List.second.name}, and find me something similar"
                    #     puts ""
                    #     # yes_or_no = prompt.yes?("Would you like to add this to #{List.second.name} ?")
                    #     # if yes_or_no
                    #         # List.second.animes << current_anime
                    #         # puts ""
                    #         # puts "Awesome! We've added #{current_anime.title} to your collection."
                    #     # end 
                    #     already_displayed_array = []
                    #     already_displayed_array << current_anime
                    #     current_producer = current_anime.producer
                    #     filtered_anime_data = current_producer.animes - already_displayed_array
                    #     round_counter += 1
                    #     if filtered_anime_data == []
                    #         #just in case there is no more animes from this producer
                    #         current_anime = sorted_anime[round_counter]
                    #     else
                    #         current_anime = filtered_anime_data.first
                    #     end
                    #     sleep (2)
                    #     puts ""
                    #     puts "Here is a similar Anime!"
                    #     #how to loop up change the current_anime
                    # end
                    if choice == "Keep browsing"
                        puts ""
                        puts "Good thing we've got hundreds of other Anime, here is another!"
                        List.third.animes << current_anime
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

        if first_menu == "Search by Title"
            search_status = "go"
            while search_status == "go" do
                puts "Please enter the anime you want to search"
                title = gets.chomp
                anime_found = Anime.find_by(title: title)
                if anime_found
                    puts "title: #{anime_found.title}"
                    puts "rating: #{anime_found.rating}"
                    puts "producer: #{anime_found.producer.name}"
                    puts "synopsis: #{anime_found.synopsis}"
                    #elaborate 
                    search_choice = prompt.select("What would you like to do with this anime", "Add to a list", "Search for another", "Exit")
                    if search_choice == "Add to a list"
                        multiple_choices_search = [List.first.name, List.second.name]
                        multiple_search_return = prompt.multi_select("Which list(s) would you like to add to", multiple_choices_search)
                        if multiple_search_return == [List.first.name]
                            if List.first.animes.exists?(anime_found)
                                puts "This Anime is already on #{List.first.name}"
                            else
                                List.first.animes << anime_found
                                puts ""
                                puts "DONE! We've added #{anime_found.title} to #{List.first.name}!"
                            end
                        end

                        if multiple_search_return == [List.second.name]
                            if List.second.animes.exists?(anime_found)
                                puts "This Anime is already on #{List.second.name}"
                            else
                                List.second.animes << anime_found
                                puts ""
                                puts "DONE! We've added #{anime_found.title} to #{List.second.name}!"
                            end                            
                        end

                        if multiple_search_return == [List.first.name, List.second.name]
                            #NOT DONE!
                            if List.first.animes.exists?(anime_found)
                                if List.second.animes.exists?(anime_found)
                                    puts "This Anime is already on #{List.second.name}"
                                else
                                    List.second.animes << anime_found
                                    puts ""
                                    puts "DONE! We've added #{anime_found.title} to #{List.second.name}!"
                                end
                                puts "This Anime is already on #{List.first.name}"
                            else
                                if List.second.animes.exists?(anime_found)
                                    puts "This Anime is already on #{List.second.name}"
                                else
                                    List.second.animes << anime_found
                                    puts ""
                                    puts "DONE! We've added #{anime_found.title} to #{List.second.name}!"
                                end
                                List.first.animes << anime_found
                                puts ""
                                puts "DONE! We've added #{anime_found.title} to #{List.first.name}!"
                            end

                        #     List.first.animes << anime_found
                        #     List.second.animes << anime_found
                        #     puts ""
                        #     puts "DONE! We've added #{anime_found.title} to both lists!"
                        end
                        search_status = "end"
                    end

                    if search_choice == "Search for another"
                    end

                    if search_choice == "Exit"
                        search_status = "end"
                    end
                else
                    puts "Sorry we couldn't find that Anime :("
                end
            end
        end
 
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
                remove_loop = "go"
                while remove_loop == "go"
                    title_to_remove = gets.chomp.strip
                    #iterates over the list that the user has chosen to match the title with the input 
                    #and then to destroy the instance from the list
                    if list.exists?(title: title_to_remove)
                        list.each do |anime|
                            if anime.title == title_to_remove
                                remove_loop = "end"
                                list.delete(anime)
                                puts ""
                                puts "We have removed #{title_to_remove} from your list."
                                puts ""
                            end 
                        end
                    else 
                            puts ""
                            puts "Sorry, we cannot find that Anime. Please try again:"
                            puts ""
                    end
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

        if first_menu == "Exit"
            puts ""
            puts "Thank you for using My Anime Lists. NOW GO WATCH SOME ANIME!"
            puts ""
            menu_loop = "end"
        end
end
    








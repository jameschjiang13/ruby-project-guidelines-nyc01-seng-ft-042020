require_relative '../config/environment'
require "tty-prompt"
prompt = TTY::Prompt.new
require 'pry'

def welcome_message
    puts ""
    puts "Welcome to My Anime Lists!"
    puts ""
    puts "*******************************"
    puts ""
    sleep(1)
    puts "A place to find new Anime and organize your favorites."
    puts ""
    sleep(1)
    puts "Lets get started!"
    sleep(1)
    puts ""
end 

def sorted_anime
    Anime.order("rating DESC")
end

def main_menu
    prompt = TTY::Prompt.new 
    first_menu = prompt.select("Menu:", "Browse Top Anime", "View/Edit My Lists", "Exit")
    if first_menu == "Browse Top Anime"
        browse_top_anime
    end
    # if first_menu == "Search by Title"
    #     search_by_title
    # end
    if first_menu == "View/Edit My Lists"
        view_edit
    end
    if first_menu == "Exit"
        exit_app
    end
end 

def browse_anime_menu
    prompt = TTY::Prompt.new 
    choice = prompt.select("Choose an option", "Add to a list", "Keep browsing", "Done! Show me My Lists")
    if choice == "Add to a list"
        add_to_list
    end 
    if choice == "Keep browsing"
        system("clear")
        puts ""
        puts "Good thing we've got hundreds of other Anime, here is another!"
        List.third.animes << current_anime
        browse_top_anime
    end
    if choice == "Done! Show me My Lists"
        system("clear")
        puts ""
        puts "Here are your final lists. Happy watching!"
        display_first_list
        display_second_list
        puts ""
        main_menu
    end
end

def browse_top_anime
    current_anime
    puts ""
    puts "Tile: #{current_anime.title}\nRating: #{current_anime.rating}\nSynopsis: #{current_anime.synopsis}"
    puts ""
    browse_anime_menu
end 

def current_anime
    (sorted_anime - List.first.animes - List.second.animes - List.third.animes)[0]
end 

def view_edit
    prompt = TTY::Prompt.new
    inside_view_edit = prompt.select("Would you like to:", "View your lists", "Remove an Anime", "Update list name", "Exit")
    if inside_view_edit == "View your lists"
        list_prompt = prompt.select("Choose the list you would like to view:", List.first.name, List.second.name)
        if list_prompt == List.first.name
            display_first_list
            puts ""
            main_menu
        end
        if list_prompt == List.second.name
            display_second_list
            puts ""
            main_menu
        end
    end
    if inside_view_edit == "Remove an Anime"
        remove_anime
    end
    if inside_view_edit == "Update list name"
        update_list_name 
    end
    if inside_view_edit == "Exit"
        main_menu
    end
end 

def remove_anime
    prompt = TTY::Prompt.new
    remove_from_list = prompt.select("Which list would you like to remove from?", List.first.name, List.second.name)
    if remove_from_list == List.first.name
       display_first_list
       gets_remove(List.first.animes)
    end
    if remove_from_list == List.second.name
        display_second_list 
        gets_remove(List.second.animes)
    end 
    main_menu
end

def gets_remove(list)
    puts ""
    puts "Please type the name of the Anime you would like to remove:"
    puts ""
    title_to_remove = gets.chomp.strip
    if list.exists?(title: title_to_remove)
        list.each do |anime|
            if anime.title == title_to_remove
                list.delete(anime)
                puts ""
                puts "We have removed #{title_to_remove} from your list."
                puts ""
                #MAIN MENU???
            end
        end
    else
        sorry_try_again(list)
    end
end 

def sorry_try_again(list)
    puts ""
    puts "Sorry, we cannot find that Anime. Please try again."
    puts ""
    gets_remove(list)
end

def update_list_name
    prompt = TTY::Prompt.new
    edit_name = prompt.select("Which list name would you like to change?", List.first.name, List.second.name)
    if edit_name == List.first.name
        system("clear")
        puts ""
        puts "Here is the name of your current list: #{List.first.name}"
        puts ""
        gets_update(List.first)
    end
    if edit_name == List.second.name
        system("clear")
        puts ""
        puts "Here is the name of your current list: #{List.second.name}"
        puts ""
        gets_update(List.second)
    end
end

def gets_update(list)
    puts "Please type the new name of your list:"
    puts ""
    name_change = gets.chomp.strip
    list.update(name: name_change)
    puts ""
    puts "Great! We have changed the name of your list to: #{name_change}"
    puts ""
    main_menu
end 

def exit_app
    system("clear")
    puts "****************************************************************"
    puts ""
    puts "Thank you for using My Anime Lists. NOW GO WATCH SOME ANIME!"
    puts ""
    puts "****************************************************************"
    puts ""
end 

def add_to_list
    prompt = TTY::Prompt.new
    multiple_choices = [List.first.name, List.second.name]
    multiple_return = prompt.multi_select("Which list(s) would you like to add to", multiple_choices)
    if multiple_return == [List.first.name]
        List.first.animes << current_anime
        puts ""
        system("clear")
        puts "DONE! We've added #{current_anime.title} to #{List.first.name}!\n\nHere is another Anime:"
    end
    if multiple_return == [List.second.name]
        List.second.animes << current_anime
        puts ""
        system("clear")
        puts "DONE! We've added #{current_anime.title} to #{List.second.name}!\n\nHere is another Anime:"
    end
    if multiple_return == [List.first.name, List.second.name]
        actual_current_anime = current_anime
        List.first.animes << actual_current_anime
        List.second.animes << actual_current_anime
        puts ""
        system("clear")
        puts "DONE! We've added #{actual_current_anime.title} to both lists!\n\nHere is another Anime:"
    end
    browse_top_anime
end

def display_first_list
    puts ""
    puts "#{List.first.name}:"
    puts ""
    puts "*******************************"
    sleep(1)
    anime_title_array = 
    List.first.animes.map do |anime|       
        "\n #{anime.title}"
    end
    puts anime_title_array
    sleep(1)
end 

def display_second_list
    puts ""
    puts "#{List.second.name}:"
    puts ""
    puts "*******************************"
    sleep(1)
    anime_title_array = 
    List.second.animes.map do |anime|       
        "\n #{anime.title}"
    end
    puts anime_title_array
end 

def search_by_title
    prompt = TTY::Prompt.new
    puts ""
    puts "Please enter the anime you want to search:"
    puts ""
    title = gets.chomp.strip
    anime_found = Anime.find_by(title: title)
    if anime_found
        puts "title: #{anime_found.title}"
        puts "rating: #{anime_found.rating}"
        puts "producer: #{anime_found.producer.name}"
        puts "synopsis: #{anime_found.synopsis}"
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
                    if List.first.animes.exists?(anime_found)
                        puts "This Anime is already on #{List.first.name}"
                        if List.second.animes.exists?(anime_found)
                            puts "This Anime is already on #{List.second.name}"
                        else
                            List.second.animes << anime_found
                            puts ""
                            puts "DONE! We've added #{anime_found.title} to #{List.second.name}!"
                        end
                        
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
                end
            end

            if search_choice == "Search for another"
            end

            if search_choice == "Exit"
            end
    else
       sorry_not_found
    end
end

def sorry_not_found
    puts "" 
    puts "Sorry we couldn't find that Anime :("
    puts ""
    yes_or_no = prompt.yes?(“search again?“)
        if yes_or_no
            search_by_title
        else
            main_menu
        end 
end


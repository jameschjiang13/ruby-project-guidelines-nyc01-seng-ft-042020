require_relative '../config/environment'
require "tty-prompt"
prompt = TTY::Prompt.new


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
    first_menu = prompt.select("Menu:", "Browse Top Anime", "Search by Title", "View/Edit My Lists", "Exit")
    if first_menu == "Browse Top Anime"
        browse_top_anime
    end
    if first_menu == "Search by Title"
        search_by_title
    end
    if first_menu == "View/Edit My Lists"

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
        puts ""
        puts "Good thing we've got hundreds of other Anime, here is another!"
        List.third.animes << current_anime
        browse_top_anime
    end
    if choice == "Done! Show me My Lists"
        puts ""
        puts "Here are your final lists. Happy watching!"
        puts ""
        display_list(first)
        display_list(second) 
        # main_menu
    end
end

def browse_top_anime
    current_anime
    # current_anime = (sorted_anime - List.first.animes - List.second.animes - List.third.animes)[0]
    puts ""
    puts "Tile: #{current_anime.title}\nRating: #{current_anime.rating}\nSynopsis: #{current_anime.synopsis}"
    puts ""
    browse_anime_menu
end 

def current_anime
    (sorted_anime - List.first.animes - List.second.animes - List.third.animes)[0]
end 

def search_by_title

end 

def view_edit_lists
end 

def exit_app
    puts ""
    puts "Thank you for using My Anime Lists. NOW GO WATCH SOME ANIME!"
    puts "" 
end 

def add_to_list
    prompt = TTY::Prompt.new
    multiple_choices = [List.first.name, List.second.name]
    multiple_return = prompt.multi_select("Which list(s) would you like to add to", multiple_choices)
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
        List.second.animes << current_anime
        puts ""
        puts "DONE! We've added #{current_anime.title} to both lists!\n\nHere is another Anime"
    end
    browse_top_anime
    browse_anime_menu
end

def display_list(list_index)
    #display_list(first)
    sleep(2)
    puts "#{List.list_index.name}:"
    puts ""
    anime_title_array = 
    List.list_index.animes.map do |anime|       
        "\n #{anime.title}"
    end
    puts anime_title_array
end 


welcome_message

main_menu


# def display_anime_list 

# end 

# def browse_anime 

# end 


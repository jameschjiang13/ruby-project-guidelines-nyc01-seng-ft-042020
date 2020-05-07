require_relative '../config/environment'
require "tty-prompt"
prompt = TTY::Prompt.new

def sorted_anime
    Anime.order("rating DESC")
end


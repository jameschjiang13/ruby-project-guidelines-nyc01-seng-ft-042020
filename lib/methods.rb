def sorted_anime
    Anime.order("rating DESC")
end
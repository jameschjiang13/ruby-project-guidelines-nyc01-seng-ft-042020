class AnimeList < ActiveRecord::Base
    belongs_to :list
    belongs_to :anime
end
class List < ActiveRecord::Base
    has_many :anime_lists 
    has_many :animes, through: :anime_lists

    
end 
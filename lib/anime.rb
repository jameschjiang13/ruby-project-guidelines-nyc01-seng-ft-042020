class Anime < ActiveRecord::Base
    belongs_to :producer
    has_many :anime_lists
    has_many :lists, through: :anime_list
end 

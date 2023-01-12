class Song < ApplicationRecord
    belongs_to :user
    has_many :playlists, :through => :playlist_tracks
    
end

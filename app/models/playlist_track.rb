class PlaylistTrack < ApplicationRecord
    validates :song_id_id, presence: true
    validates :playlist_id_id, presence: true

    belongs_to :song
    belongs_to :playlist
end

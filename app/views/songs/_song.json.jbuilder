json.extract! song, :id, :title, :genre, :release_data, :song_id, :artist_id, :album, :created_at, :updated_at
json.url song_url(song, format: :json)

json.extract! playlist, :id, :name, :playlist_id, :user_id, :created_at, :updated_at
json.url playlist_url(playlist, format: :json)

class DropPlaylistTracks < ActiveRecord::Migration[7.0]
  def change
    drop_table :playlist_tracks
  end
end

class PlaylistTrack < ActiveRecord::Migration[7.0]
  def change
    create_table :playlist_tracks do |t|
      t.references :playlist_id, null: false, foreign_key: true
      t.references :song_id, null: false, foreign_key: true
    end 
  end
end

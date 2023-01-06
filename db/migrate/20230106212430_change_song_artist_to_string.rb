class ChangeSongArtistToString < ActiveRecord::Migration[7.0]
  def change
    change_column :songs, :artist_id, :string
  end
end

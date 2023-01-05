class CreateSongs < ActiveRecord::Migration[7.0]
  def change
    create_table :songs do |t|
      t.string :title
      t.string :genre
      t.string :release_data
      t.integer :song_id
      t.integer :artist_id
      t.string :album

      t.timestamps
    end
  end
end

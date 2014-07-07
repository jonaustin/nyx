class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :artist
      t.string :spotify_id
      t.integer :order
      t.integer :playlist_id

      t.timestamps
    end
  end
end

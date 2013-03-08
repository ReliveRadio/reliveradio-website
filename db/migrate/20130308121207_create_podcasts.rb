class CreatePodcasts < ActiveRecord::Migration
  def change
    create_table :podcasts do |t|
      t.string :name
      t.string :url
      t.string :slugintern
      t.string :flattrhandle
      t.string :twitterhandle
      t.string :hoersuppeslug
      t.string :feedurl
      t.string :artistname

      t.timestamps
    end
  end
end

class AddAdnAccountToPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :adnhandle, :str
  end
end

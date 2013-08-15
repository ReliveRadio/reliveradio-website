class AddAdnAccountToPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :adnhandle, :string
  end
end

class AddDescriptionColumnToPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :description, :string
  end
end

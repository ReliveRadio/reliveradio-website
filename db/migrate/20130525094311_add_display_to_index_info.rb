class AddDisplayToIndexInfo < ActiveRecord::Migration
  def change
    add_column :index_infos, :display, :boolean
  end
end

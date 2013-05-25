class CreateIndexInfos < ActiveRecord::Migration
  def change
    create_table :index_infos do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end

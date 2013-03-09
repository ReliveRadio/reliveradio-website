require 'csv'

class Podcast < ActiveRecord::Base
  attr_accessible :artistname, :feedurl, :flattrhandle, :hoersuppeslug, :name, :slugintern, :twitterhandle, :url, :description

	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
	        csv << column_names
	        all.each do |podcast|
	          csv << podcast.attributes.values_at(*column_names)
	        end
        end
	end

	def self.import(file)
	  CSV.foreach(file.path, headers: true) do |row|
	    podcast = find_by_id(row["id"]) || new
	    podcast.attributes = row.to_hash.slice(*accessible_attributes)
	    podcast.save!
	  end
	end

end

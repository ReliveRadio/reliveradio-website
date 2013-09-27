require 'timeout'
require 'net/http'

module ExternalApiHelper

	def self.fetch_json(url)
		begin
			result = Timeout::timeout(2) do # 2 seconds
				# operation that may cause a timeout
				uri = URI.parse(url)
				http = Net::HTTP.new(uri.host, uri.port)
				request = Net::HTTP::Get.new(uri.request_uri)
				response = http.request(request)
				return JSON.parse(response.body)
			end
			return result
		rescue
			# if any error happens in the block above, return empty string
			# this will result in fetch_json_with_cache using the last value in cache
			# as long as no new data arrives
			return ""
		end
	end

	def self.fetch_json_with_cache(url, expire_time)
		cache_id = url
		cache = Rails.cache.read(cache_id) # get cache content

		# if cache is not expired and contains valid data, return cache
		# cache_fresh is nil, if cache time is expired
		if ( !Rails.cache.read('cache_fresh' + cache_id).blank? && !cache.blank?)
			return cache
		else
			# cache is expired or does not contain valid data
			# fetch new data
			new_data = fetch_json(url)
			if !new_data.blank?
				# if new data is valid, save it in cache and return it
				Rails.cache.write(cache_id, new_data)
				# setup cache_fresh to know when the cache has to be refilled in the future
				Rails.cache.write('cache_fresh' + cache_id, 'fresh', :expires_in => expire_time)
				return new_data
			else
				# new data is invalid. maybe the old cache data is ok
				if !cache.blank?
					# if it is ok, use it
					return cache
				else
					# otherwise we can not return any valid data. raise an error
					raise "External API Error. Could not reach " + url + " . The cache also did not contain valid data."
				end
			end
		end
	end

end

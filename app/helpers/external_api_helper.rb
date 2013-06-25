module ExternalApiHelper

	require 'timeout'
	require 'net/http'

	def self.fetch_json(url)
		Timeout::timeout(1) do # 1 second
			# operation that may cause a timeout
			uri = URI.parse(url)
			http = Net::HTTP.new(uri.host, uri.port)
			request = Net::HTTP::Get.new(uri.request_uri)
			response = http.request(request)
			return JSON.parse(response.body)
		end
		rescue Timeout::Error, Errno::ECONNREFUSED, Errno::EINVAL, Errno::ECONNRESET, EOFError, Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
			return ""
	end

	def self.fetch_json_with_cache(url, expire_time)
		cache_backup = Rails.cache.read(url)
		api_data = Rails.cache.fetch(url, :expires_in => expire_time) do
			new_data = fetch_json(url)
			if new_data.blank?
				# if API fetch did not return valid data, return the old cache state
				cache_backup
			else
				new_data
			end
		end

		return api_data
	end

end

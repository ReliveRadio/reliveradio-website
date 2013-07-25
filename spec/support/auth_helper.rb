module AuthHelper
	def http_login
		user = PasswordHelper.user
		pw = PasswordHelper.password
		request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
	end  
end
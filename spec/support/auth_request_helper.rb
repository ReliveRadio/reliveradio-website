module AuthRequestHelper
  #
  # pass the @env along with your request, eg:
  #
  # GET '/labels', {}, @env
  #
  def http_login
    @env ||= {}
    user = AUTHENTICATION_CONFIG['username']
    pw = AUTHENTICATION_CONFIG['password']
    @env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end
end
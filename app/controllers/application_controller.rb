class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	@messages = Message.new
end

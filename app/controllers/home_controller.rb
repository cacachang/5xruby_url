class HomeController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @urls = Url.all
    @env = ENV['DOMAIN']
  end
end

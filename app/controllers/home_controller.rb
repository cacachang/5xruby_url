class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @urls = Url.all
    @env = ENV.fetch('DOMAIN', 'localhost:3000')
  end
end

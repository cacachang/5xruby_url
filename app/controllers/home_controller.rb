class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @env = ENV.fetch('DOMAIN', 'localhost:3000')
    if params[:query].present?
      @search = Url.where("page LIKE ?", "%#{params[:query]}%") 
    else
      @search = Url.all
    end
  end
end

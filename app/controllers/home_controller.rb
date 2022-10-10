# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @env = ENV.fetch('DOMAIN', 'localhost:3000')
    if params[:query].present?
      @search = current_user.urls.where('page LIKE ?', "%#{params[:query]}%")
    else
      @search = current_user.urls
    end
  end
end

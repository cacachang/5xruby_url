# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @env = ENV.fetch('DOMAIN', 'localhost:3000')
    @search = if params[:query].present?
                current_user.urls.where('page LIKE ?', "%#{params[:query]}%")
              else
                current_user.urls
              end
  end
end

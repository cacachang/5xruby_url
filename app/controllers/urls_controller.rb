class UrlsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_url, only: [:show, :edit, :update, :destroy]

  require 'uri'

  def new
    @url = current_user.urls.new
    @campaign = @url.build_campaign
  end

  def create
    @url = current_user.urls.new(url_params)
    @campaign = @url.build_campaign(campaign_params)

    uri = URI.parse(@url[:page])

    if @url.save || @campaign.save
      redirect_to '/', notice: "新增成功"
    else
      render :new
    end
  end

  def show
    redirect_to @url.page, allow_other_host: true
  end

  def edit
  end

  def update
    if @url.save || @campaign.save
      redirect_to '/', notice: "編輯成功"
    else
      render :new
    end
  end

  def destroy
    @url.destroy
    @campaign.destroy

    redirect_to '/', notice: '刪除成功'
  end

  private
  def url_params
    params.require(:url).permit(:page)
  end

  def find_url
    @url = Url.find(params[:id])
  end

  def campaign_params
    params.require(:campaign).permit(:source, :medium, :name, :term, :content)
  end
end

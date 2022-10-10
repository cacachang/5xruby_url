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
    utm_query()


    if @url.save || @campaign.save
      redirect_to '/', notice: "新增成功"
    else
      render :new
    end
  end

  def show
    redirect_to @url.utm_url, allow_other_host: true
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
    @campaign = @url.campaign
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

  def utm_query
    utm_source = @campaign.source != "" && "utm_source=#{@campaign.source}"
    utm_medium = @campaign.medium != "" && "utm_medium=#{@campaign.medium}"
    utm_campaign = @campaign.name != "" && "utm_campaign=#{@campaign.name}"
    utm_term = @campaign.term != "" && "utm_term=#{@campaign.term}"
    utm_content = @campaign.content != "" && "utm_content=#{@campaign.content}"
   
    utm =[utm_source, utm_medium, utm_campaign, utm_term, utm_content].select{|utm| utm != false }.join("&")

    uri = URI.parse(@url[:page])
    new_query_ary = URI.decode_www_form(utm)
    uri.query = URI.encode_www_form(new_query_ary)

    @url[:utm_url] = uri
  end
end

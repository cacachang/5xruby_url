# frozen_string_literal: true

class UrlsController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :find_url, only: %i[edit update destroy]

  def new
    @url = current_user.urls.new
    @campaign = @url.build_campaign
  end

  def create
    @url = current_user.urls.new(url_params)
    @campaign = @url.build_campaign(campaign_params)
    utm_query

    if @url.save && @campaign.save
      redirect_to '/', notice: '新增成功'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @url_short = Url.find_by(shortener: params[:id])
    @url_short.click_logs.create if @url_short
    redirect_to @url_short.utm_url, allow_other_host: true
  end

  def edit; end

  def update
    @campaign = @url.campaign
    @campaign.update(campaign_params)
    utm_query

    if @url.update(url_params)
      redirect_to '/', notice: '編輯成功'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @campaign = @url.campaign
    @url.update(deleted_at: Time.now)
    @campaign.update(deleted_at: Time.now)

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
    utm_source = @campaign.source != '' && "utm_source=#{@campaign.source}"
    utm_medium = @campaign.medium != '' && "utm_medium=#{@campaign.medium}"
    utm_campaign = @campaign.name != '' && "utm_campaign=#{@campaign.name}"
    utm_term = @campaign.term != '' && "utm_term=#{@campaign.term}"
    utm_content = @campaign.content != '' && "utm_content=#{@campaign.content}"

    utm = [utm_source, utm_medium, utm_campaign, utm_term, utm_content].reject { |utm| utm == false }.join('&')

    uri = URI.parse(@url[:page])
    new_query_ary = URI.decode_www_form(utm)
    uri.query = URI.encode_www_form(new_query_ary) if utm.size > 0

    @url[:utm_url] = uri
  end
end

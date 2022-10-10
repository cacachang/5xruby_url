# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :find_url
  before_action :find_tag, only: %i[edit update destroy]

  def new
    @tag = @url.build_tag
  end

  def create
    @tag = @url.build_tag(tag_params)

    if @tag.save
      redirect_to root_path, notice: '新增成功'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @tag.update(tag_params)
      redirect_to root_path, notice: '修改成功'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tag.destroy

    redirect_to root_path, notice: '刪除成功'
  end

  private

  def find_url
    @url = Url.find(params[:url_id])
  end

  def find_tag
    @tag = @url.tag
  end

  def tag_params
    params.require(:tag).permit(:tag)
  end
end

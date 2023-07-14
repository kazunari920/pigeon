# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.create!(photographer_id: params[:photographer_id])
    redirect_to photographer_path(params[:photographer_id])
  end

  def destroy
    @like = Like.find_by(photographer_id: params[:photographer_id], user_id: current_user.id)
    @like.destroy
    redirect_to photographer_path(params[:photographer_id])
  end
end
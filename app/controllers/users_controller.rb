# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.order(:id).page(params[:page]).per(3)
  end
end

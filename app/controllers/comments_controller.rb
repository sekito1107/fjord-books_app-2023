# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      flash[:alert] = t('controllers.common.alert_create', name: Comment.model_name.human)
    end
    redirect_to @commentable
  end

  def edit; end

  def update
    if @comment.user == current_user && @comment.update(comment_params)
      redirect_to @commentable, notice: t('controllers.common.notice_update', name: Comment.model_name.human)
    else
      redirect_to @commentable, alert: t('controllers.common.alert_auth', name: Comment.model_name.human)
    end
  end

  def destroy
    if @comment.user == current_user
      @comment.destroy
      flash[:notice] = t('controllers.common.notice_destroy', name: Comment.model_name.human)
    else
      flash[:alert] = t('controllers.common.alert_destroy', name: Comment.model_name.human)
    end
    redirect_to @commentable
  end

  private

  def set_commentable
    if params[:book_id]
      @commentable = Book.find(params[:book_id])
    elsif params[:report_id]
      @commentable = Report.find(params[:report_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end

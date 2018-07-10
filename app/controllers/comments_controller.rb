class CommentsController < ApplicationController

  before_action :set_post

  def index

  end

  def show

  end

  def new

  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      # flash[:success] = "Commented"
      # redirect_to root_path
      respond_to do |format|
        format.html {redirect_to root_path}
        format.js
      end
    else
      flash[:alert] = "Comment is wrong"
      render root_path
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])

    if @comment.user_id == current_user.id
      @comment.delete
        respond_to do |format|
          format.html {redirect_to root_path}
          format.js
        end
      end
    # @comment.destroy
    # flash[:success] = "Comment deleted :("
    # redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

end

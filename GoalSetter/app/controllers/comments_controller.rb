class CommentsController < ApplicationController
  
  def create
    @comment = current_user.authored_comments.new(comment_params)
    if @comment.commentable_type == "User"
      user = User.find(@comment.commentable_id)
    else
      user = Goal.find(@comment.commentable_id).user
    end
    
    unless @comment.save
      flash.now[:errors] = @comment.errors.full_messages
    end
    redirect_to user_url(user)
  end
  
  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :body)
  end
  
end

class CommentsController < ApplicationController

  def create
    comment = Comments::CreateComment.run(params.fetch(:comment, {})
                                       .merge!({
                                                 user: current_user,
                                                 post: current_post
                                               }))

    if comment.valid?
      flash[:notice] = t 'comments.created'
    else
      flash[:alert] = post.errors.full_messages.to_sentence
    end
    redirect_to current_post
  end

  def destroy
    result = Comments::DestroyComment.run(comment: current_comment)

    if result.valid?
      flash[:notice] = t 'comments.destroyed'
    else
      flash[:alert] = result.errors.full_messages.to_sentence
    end
    redirect_to current_post
  end

  private

  def current_post
    @current_post ||= Posts::FindPost.run!(id: params[:post_id])
  end

  def current_comment
    @current_comment ||= Comments::FindComment.run!(id: params[:id])
  end
end

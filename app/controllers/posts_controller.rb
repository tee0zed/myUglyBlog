class PostsController < ApplicationController

  def index
    @posts = Posts::ListPosts.run!(blog: current_blog)
  end

  def show
    @post = current_post
  end

  def new
    @post = Posts::CreatePost.new
  end

  def create
    post = Posts::CreatePost.run(params.fetch(:post, {})
                                       .merge!({
                                                 user: current_user,
                                                 blog: current_blog
                                               }))

    if post.valid?
      flash[:notice] = t 'post.created'
      redirect_to current_post
    else
      flash[:alert] = post.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @post = Posts::UpdatePost.new(
      post: current_post,
      blog: current_blog,
      title: current_post.title,
      content: current_post.content
    )
  end

  def update
    inputs = { post: current_post }.reverse_merge(params[:post])
    post = Blogs::UpdateBlog.run(inputs)

    if post.valid?
      flash[:notice] = t 'post.updated'
    else
      flash[:alert] = post.errors.full_messages.to_sentence
    end
    redirect_to current_post
  end

  def destroy
    result = Posts::DestroyPost.run(post: @current_post)

    if result.valid?
      flash[:notice] = t 'post.destroyed'
    else
      flash[:alert] = result.errors.full_messages.to_sentence
    end
    redirect_to current_blog
  end

  private

  def current_post
    @current_post ||= Posts::FindPost.run!(id: params[:id])
  end
end

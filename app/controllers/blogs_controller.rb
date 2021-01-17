class BlogsController < ApplicationController
  before_action :ensure_subdomain, except: %i[new create index]

  def index
    @blogs = Blogs::ListBlogs.run!
  end

  def show
    @blog = current_blog
  end

  def new
    @blog = Blogs::CreateBlog.new
  end

  def create
    blog = Blogs::CreateBlog.run(params.fetch(:blog, {}).merge!({user: current_user}))

    if blog.valid?
      flash[:notice] = t 'blog.created'
      redirect_to blog.result
    else
      flash[:alert] = blog.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @blog = Blogs::UpdateBlog.new(
      blog: current_blog,
      title: current_blog.title,
      subdomain: current_blog.subdomain
    )
  end

  def update
    inputs = { blog: current_blog }.reverse_merge(params[:blog])
    blog = Blogs::UpdateBlog.run(inputs)

    if blog.valid?
      flash[:notice] = t 'blog.updated'
    else
      flash[:alert] = blog.errors.full_messages.to_sentence
    end
    redirect_to current_blog
  end

  def destroy
    result = Blogs::DestroyBlog.run(blog: current_blog)

    if result.valid?
      flash[:notice] = t 'blog.destroyed'
    else
      flash[:alert] = result.errors.full_messages.to_sentence
    end
    redirect_to root_path
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  helper_method :current_blog, :ensure_subdomain

  private

  def current_blog
    @current_blog ||= Blogs::FindBlog.run!(subdomain: request.subdomain)
  end

  def ensure_subdomain
    redirect_to blogs_path unless current_blog.present?
  end
end

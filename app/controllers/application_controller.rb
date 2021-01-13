class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_blog

  def current_blog
    @current_blog ||= Blogs::FindBlog.run!(subdomain: request.subdomain)
  end

  private

  def ensure_subdomain
    redirect_to root_path unless current_blog.present?
  end
end
